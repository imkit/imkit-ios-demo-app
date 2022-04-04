//
//  ShareModel.swift
//  ShareExtension
//
//  Created by SHI-BO LIN on 2022/3/29.
//

import IMKit


class ShareTask {
    enum Status {
        case prepare
        case sending
        case done
    }
    
    var roomID: String
    var messages = [ShareMessage]() {
        didSet {
            if messages.count == 0 {
                status = .done
            }
        }
    }
    var status = Status.prepare
    
    init(roomID: String) {
        self.roomID = roomID
    }
}

class ShareMessage {
    var message: IMMessage
    var contentId: String
    init(contentId: String = "", message: IMMessage) {
        self.contentId = contentId
        self.message = message
    }
}




class ShareContent {
    var texts: [ShareText]
    var images: [ShareImage]
    var videos: [ShareVideo]
    
    init(texts: [ShareText], images: [ShareImage], videos: [ShareVideo]) {
        self.texts = texts
        self.images = images
        self.videos = videos
    }
}

class ShareImage {
    var image: UIImage
    var id: String
    
    var uploaded = false
    
    init(id: String, image: UIImage) {
        self.id = id
        self.image = image
    }
}

class ShareText {
    var text: String
    var id: String
    
    var uploaded = false
    
    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
}

class ShareVideo {
    var url: URL
    var id: String
    var thumbnail: IMImage?
    
    var uploaded = false
    
    init(id: String, url: URL) {
        self.id = id
        self.url = url
    }
}


enum ShareError: Error {
    case imageNotFound
    case imageUploadFailed
    case videoUploadFailed
}

enum ItemType: CaseIterable {
    case text
    case url
    case image
    case video
    
    var identifier: String {
        switch self {
        case .text:
            return "public.plain-text"
        case .url:
            return "public.url"
        case .image:
            return "public.image"
        case .video:
            return "public.movie"
        }
    }
    
    var hasText: Bool {
        switch self {
        case .text,
             .url:
            return true
        default:
            return false
        }
    }
}
