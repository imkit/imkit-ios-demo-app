//
//  ShareManager.swift
//  ShareExtension
//
//  Created by SHI-BO LIN on 2022/3/29.
//

import Foundation
import IMKit
import AVFoundation


class ShareManager {
    typealias UploadProgressBlock = ((ItemType, Float) -> Void)
    typealias ProgressBlock = ((_ completedCount: Int, _ total: Int) -> Void)
    typealias CompleteBlock = ((Bool, Error?) -> Void)
    
    private var roomIds: [String]?
    private var tasks = [ShareTask]()
    private var uploadProgress: UploadProgressBlock?
    private var progress: ProgressBlock?
    private var complete: CompleteBlock?
    private var currentTask: ShareTask?
    private var shareContent: ShareContent?
    private var uploadedIMImages = [String: IMImage]()
    private var imagesUploadProgress = [String: Float]()
    private var uploadedIMVideos = [String: IMFile]()
    private var uploadedVideoThumbnails = [String: IMImage]()
    private var videosUploadProgress = [String: Float]()
    
    init() {
        IMMessagesManager.shared.configure(delegate: self)
    }
    
    private func reset() {
        currentTask = nil
        shareContent = nil
        uploadedIMImages.removeAll()
        imagesUploadProgress.removeAll()
        uploadedIMVideos.removeAll()
        videosUploadProgress.removeAll()
        uploadedVideoThumbnails.removeAll()
        tasks.removeAll()
    }
    
    func share(_ shareContent: ShareContent, toRooms roomIds: [String], uploadProgress: UploadProgressBlock?, progress: ProgressBlock?, complete: CompleteBlock?) {
        reset()
        self.roomIds = roomIds
        self.uploadProgress = uploadProgress
        self.progress = progress
        self.complete = complete
        self.shareContent = shareContent
        
        for roomId in roomIds {
            let shareTask = ShareTask(roomID: roomId)
            
            if !shareContent.texts.isEmpty {
                for text in shareContent.texts {
                    shareTask.messages.append(ShareMessage(message: self.createTextMessage(text: text.text, roomID: roomId)))
                }
            }
            
            if shareContent.images.count > 0 {
                for image in shareContent.images {
                    imagesUploadProgress[image.id] = 0
//                    shareTask.messages.append(ShareMessage(contentId: image.id, message: self.createTempImageMessage(roomID: room.id)))
                }
            }
            
            if shareContent.videos.count > 0 {
                for video in shareContent.videos {
                    videosUploadProgress[video.id] = 0
                    shareTask.messages.append(ShareMessage(contentId: video.id, message: self.createTempVideoMessage(roomID: roomId)))
                }
            }
            
            self.tasks.append(shareTask)
        }
        startShare()
    }
    
    private func uploadImagesIfNeeded() {
        guard let shareImage = (shareContent?.images.first { $0.uploaded == false }) else {
            startShare()
            return
        }
        
        uploadImage(shareImage.image, id: shareImage.id) { (imImage) in
            shareImage.uploaded = true
            self.uploadImagesIfNeeded()
        }
    }
    
    private func uploadVideosIfNeeded() {
        guard let shareVideo = (shareContent?.videos.first { $0.uploaded == false }) else {
            startShare()
            return
        }
        
        uploadVideo(shareVideo) { (uploadedVideo, thumbnail) in
            shareVideo.uploaded = true
            shareVideo.thumbnail = thumbnail
            self.uploadVideosIfNeeded()
        }
    }
    
    private func startShare() {
        guard let shareContent = shareContent else { return }
        
        if shareContent.images.count > 0 {
            let imageUploadCompleted = !(shareContent.images.contains { $0.uploaded == false })
            guard imageUploadCompleted else {
                uploadImagesIfNeeded()
                return
            }
        }
        
        if shareContent.videos.count > 0 {
            let videoUploadCompleted = !(shareContent.videos.contains { $0.uploaded == false })
            guard videoUploadCompleted else {
                uploadVideosIfNeeded()
                return
            }
        }
        
        guard let task = (tasks.first { $0.status != .done }) else {
            complete?(true, nil)
            return
        }
        
        switch task.status {
        case .prepare:
            updateProgress()
            currentTask = task
            
            IMMessagesManager.shared.configure(roomID: task.roomID)
            
            for shareMessage in task.messages {
                switch shareMessage.message.type {
                case .Text:
                    task.status = .sending
                    sendTextMessage(shareMessage.message)
//                case .Image:
//                    task.status = .sending
//                    if let imImage = uploadedIMImages[shareMessage.contentId] {
//                        sendImageMessage(IMMessage(id: shareMessage.message.id, roomID: task.roomID, imImage: imImage, senderID: IMKit.uid))
//                    } else {
//                        guard let shareImage = (shareContent.images.first { $0.id == shareMessage.contentId }) else {
//                            return
//                        }
//                        uploadImage(shareImage.image, id: shareImage.id) { imImage in
//                            self.sendImageMessage(IMMessage(id: shareMessage.message.id, roomID: task.roomID, imImage: imImage, senderID: IMKit.uid))
//                        }
//                    }
//                case .Video:
//                    task.status = .sending
//                    if let imVideo = uploadedIMVideos[shareMessage.contentId], let thumbnail = uploadedVideoThumbnails[shareMessage.contentId] {
//                        sendVideoMessage(IMMessage(id: shareMessage.message.id, roomID: task.roomID, senderID: IMKit.uid, file: imVideo, image: thumbnail))
//                    }
                default:
                    break
                }
            }
        case .sending:
            break
        case .done:
            startShare()
        }
    }
    
    private func uploadImage(_ image: UIImage, id: String, completion: @escaping ((IMImage) -> Void)) {
        IMMessagesManager.shared.uploadIMImage(IMImage(image: image)) { [weak self] (progress) in
            guard let `self` = self else { return }
            self.imagesUploadProgress[id] = progress
            self.updateImageUploadProgress()
        } completion: { [weak self] (uploadedIMImage) in
            guard let `self` = self else { return }
            guard let uploadedIMImage = uploadedIMImage else {
                self.complete?(false, ShareError.imageUploadFailed)
                return
            }
            uploadedIMImage.originImageData = nil
            uploadedIMImage.thumbnailImageData = nil
            self.uploadedIMImages[id] = uploadedIMImage
            completion(uploadedIMImage)
        }
    }
    
    private func updateImageUploadProgress() {
        let progress = imagesUploadProgress.values.reduce(0, +) / Float(imagesUploadProgress.count)
        uploadProgress?(ItemType.image, progress)
    }
    
    private func uploadVideo(_ shareVideo: ShareVideo, completion: @escaping ((IMFile, IMImage?) -> Void)) {
        var thumbnail: IMImage?
        print("[ShareManager] uploadVideo shareVideo.url.path: \(shareVideo.url.path)")
        guard FileManager.default.fileExists(atPath: shareVideo.url.path) else {
            complete?(false, ShareError.videoUploadFailed)
            return
        }
        
        let fileExtension = shareVideo.url.pathExtension.replacingOccurrences(of: ".", with: "")
        let duration = Int(AVURLAsset(url: shareVideo.url).duration.seconds.rounded())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss"
        let mimeType = shareVideo.url.mimeType()
        let fileSize = try? shareVideo.url.resourceValues(forKeys: Set([.fileSizeKey])).fileSize
        
        if let image = shareVideo.url.thumbnail() {
            thumbnail = IMImage(image: image)
        }
        
//        IMMessagesManager.shared.uploadVideo(url: shareVideo.url, mimeType: mimeType, thumbnail: thumbnail) { [weak self] (progress) in
//            guard let `self` = self else { return }
//            self.videosUploadProgress[shareVideo.id] = progress
//            self.updateVideoUploadProgress()
//        } completion: { [weak self] (remoteURL, uploadedThumbnail) in
//            guard let `self` = self else { return }
//            guard let remoteURL = remoteURL else {
//                self.complete?(false, ShareError.videoUploadFailed)
//                return
//            }
//            uploadedThumbnail?.originImageData = nil
//            uploadedThumbnail?.thumbnailImageData = nil
//            self.uploadedVideoThumbnails[shareVideo.id] = uploadedThumbnail
//            let video = IMFile(urlString: remoteURL.absoluteString, name: dateFormatter.string(from: Date()), mimeType: mimeType, fileExtension: fileExtension, bytes: fileSize, duration: duration)
//            self.uploadedIMVideos[shareVideo.id] = video
//            completion(video, uploadedThumbnail)
//        }
    }
    
    private func updateVideoUploadProgress() {
        let progress = videosUploadProgress.values.reduce(0, +) / Float(videosUploadProgress.count)
        uploadProgress?(ItemType.video, progress)
    }
    
    private func updateProgress() {
        let completedCount = tasks.filter { $0.status == .done }.count
        progress?(completedCount, tasks.count)
    }
}

extension ShareManager {
    private func createTextMessage(text: String, roomID: String) -> IMMessage {
        return IMMessage(roomID: roomID, text: text, senderID: IMKit.uid)
    }
    
//    private func createImageMessage(image: UIImage, roomID: String) -> IMMessage {
//        return IMMessage(roomID: roomID, image: image, senderID: IMKit.uid)
//    }
//
//    private func createTempImageMessage(roomID: String) -> IMMessage {
//        return IMMessage(roomID: roomID, image: UIImage(), senderID: IMKit.uid)
//    }
    
    private func createTempVideoMessage(roomID: String) -> IMMessage {
        return IMMessage(roomID: roomID, senderID: IMKit.uid, file: IMFile(), image: IMImage())
    }
    
    private func sendTextMessage(_ message: IMMessage) {
        IMMessagesManager.shared.sendTextMessage(message: message)
    }
    
    private func sendImageMessage(_ message: IMMessage) {
//        IMMessagesManager.shared.sendUploadedImageMessage(message: message)
    }
    
    private func sendVideoMessage(_ message: IMMessage) {
//        IMMessagesManager.shared.sendUploadedFileMessage(message: message)
    }
}

extension ShareManager: IMMessagesManagerDelegate {
    func messageDidUpdate(targetMessageID: String, message: IMMessage) {
        guard let currentTask = currentTask else { return }
        currentTask.messages.removeFirst { $0.message.id == targetMessageID }
        startShare()
    }
}
