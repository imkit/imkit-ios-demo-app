//
//  CustomShareViewController.swift
//  ShareExtension
//
//  Created by SHI-BO LIN on 2022/3/29.
//

import UIKit
import IMKit
import Kingfisher
import PromiseKit

class CustomShareViewController: UIViewController {
    
    //MARK: - Properties
    private var user: User {
        return .init(uuid: "imkit", nickname: "imkit")
    }
//    private var chatToken: String {
//        return "imkit"
//    }
//
//    private var accessToken: String {
//        return "imkit"
//    }
    
    private var rooms: [IMRoom] = []
    private lazy var forwardingMessagesViewController = ForwardingMessagesViewController(customData: rooms)
    
    private var attachments: [NSItemProvider]?
    private var images = [UIImage]()
    private var texts = [String]()
    private var videoURLs = [URL]()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray6
        setupNavBar()
        setupSubviewsIfNeed()
        retrieveItemTypes()
    }
}

//MARK: - Private
private extension CustomShareViewController {
    func setupNavBar() {
        self.navigationItem.title = "IMKit Demo"

        let itemCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.setLeftBarButton(itemCancel, animated: false)

        let itemDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        self.navigationItem.setRightBarButton(itemDone, animated: false)
    }

    @objc func cancelAction () {
        let error = NSError(domain: "co.funtek.mnd.ShareExtension", code: 0, userInfo: [NSLocalizedDescriptionKey: "An error description"])
        extensionContext?.cancelRequest(withError: error)
    }

    @objc func doneAction() {

        var shareImages = [ShareImage]()
        for (index, image) in images.enumerated() {
            shareImages.append(ShareImage(id: "\(index)", image: image))
        }
        
        var shareVideos = [ShareVideo]()
        for (index, url) in videoURLs.enumerated() {
            shareVideos.append(ShareVideo(id: "\(index)", url: url))
        }
        
        var shareTexts = [ShareText]()
        for (index, string) in texts.enumerated() {
            shareTexts.append(ShareText(id: "\(index)", text: string))
        }
        
        let shareManager = ShareManager()
        let content = ShareContent(texts: shareTexts, images: shareImages, videos: shareVideos)
        shareManager.share(content, toRooms: forwardingMessagesViewController.selectedRoomIDs, uploadProgress: { [weak self] (type, progress) in
            guard let `self` = self else { return }
            guard progress > Float.leastNonzeroMagnitude else { return }
            
            let loadingText: String
            switch type {
            case .image:
                loadingText = "圖片傳送中"
            case .video:
                loadingText = "影片傳送中"
            default:
                loadingText = ""
            }

        },
        progress: { [weak self] (compeletedCount, total) in
            print("compeletedCount: \(compeletedCount) total: \(total)")
            guard let `self` = self else { return }

        },
        complete: { [weak self] (completed, error) in
            print("Share completed")
            guard let `self` = self else { return }

            if completed {
                self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
            } else {
                DispatchQueue.main.async {
                    if let error = error as? ShareError {
                        switch error {
                        case .imageNotFound:
                            print("無法找到圖片")
                        case .imageUploadFailed,
                             .videoUploadFailed:
                            print("傳送失敗，請重新傳送")
                        }
                    }
                }
            }
        })
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    
    func setupSubviewsIfNeed() {
        IMKit.applicationGroupIdentifier = "group.co.funtek.imkit-ios-sdk-v3-demo-app"
        IMKit.configure(clientKey: "fangho_imkit_0412_2018_001_clientkey", chatServerURL: URL(string: "https://chat.fangho.com")!)
        goNetworkingChatScenarioChatroomList()
    }
    
    func goNetworkingChatScenarioChatroomList() {
        let normalizedUserId: String = "\(user.uuid)networkingChat"
        IMKit.clear()
        IMKit.connect(uid: normalizedUserId)
        .then { result -> Promise<IMUser> in
            return IMUpdateMyProfileTask().perform(nickname: self.user.nickname, avatarURL: nil, description: nil)
        }
        .then { user -> Promise<[IMRoom]> in
            return when(fulfilled: [
                IMCreateDirectChatTask().perform(invitee: User.mockUserCoco.uuid),
            ])
        }.done { rooms in
            self.rooms = rooms
            print("rooms count: \(rooms.count)")
            self.showForwardingMessages()
        }.catch { error in
            print(error)
        }
    }
    
    func showLoginAlert() {
        let alert = UIAlertController(title: "Please open app and login", message:"" , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.extensionContext?.cancelRequest(withError: NSError(domain: "", code: 0, userInfo: nil))
        }))
        present(alert, animated: true, completion: nil)
    }
    

    func showForwardingMessages(){
       addChild(viewController: forwardingMessagesViewController, to: view)
    }
    
    func retrieveItemTypes() {
        guard let item = extensionContext?.inputItems.first as? NSExtensionItem
        else {
            return
        }
        guard let attachments = item.attachments else { return }
        self.attachments = attachments
        
        for attachment in attachments {
            for type in ItemType.allCases {
                if attachment.hasItemConformingToTypeIdentifier(type.identifier) {
                    
                    attachment.loadItem(forTypeIdentifier: type.identifier, options: nil) { (result, error) in
                        
                        if type.hasText {
                            if let text = result as? String {
                                self.texts.append(text)
                            } else if let url = result as? URL,
                                      !url.isFileURL {
                                self.texts.append(url.absoluteString)
                            }
                        } else if type == .image {
                            switch result {
                            case let url as URL:
                                let imageURL: URL = url as URL
                                if let image = try? UIImage(url: imageURL) {
                                    self.images.append(image)
                                }
                            case let image as UIImage:
                                self.images.append(image)
                            default:
                                break
                            }
                        } else if type == .video {
                            switch result {
                            case let url as URL:
                                self.videoURLs.append(url)
                            default:
                                break
                            }
                        }
                    }
                }
            }
        }
    }
}


class ForwardingMessagesViewController: IMForwardingMessagesViewController {
    let customData: [IMRoom]
    
    init(customData: [IMRoom]) {
        self.customData = customData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var data: [IMRoom] {
        return customData
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
