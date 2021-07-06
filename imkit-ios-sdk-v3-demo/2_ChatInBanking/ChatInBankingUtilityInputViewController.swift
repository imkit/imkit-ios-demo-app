//
//  ChatInBankingUtilityInputViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/7.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import IMKit

@objc public class ChatInBankingUtilityInputViewController: IMUtilityInputViewController {
    
    enum UtilityItem {
        case transfer
        case paymentRequest
        
        var title: String {
            switch self {
            case .transfer:
                return "轉帳"
            
             
            case .paymentRequest:
                return "收款"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .transfer:
                return UIImage(named: "chatInBankingTransferIcon")
            case .paymentRequest:
                return UIImage(named: "chatInBankingRequestIcon")
            }
        }
    }
    var array: [UtilityItem] = [
        .transfer, .paymentRequest
    ]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUtilitiesIfNeeded()
    }
    
    override public func viewDidLayoutSubviews() {
        view.frame.size.height = 85 + view.safeAreaInsets.bottom
    }
    
    func setupUtilitiesIfNeeded() {
        guard let room = (viewController as? MessagesViewController)?.viewModel.room else { return }
        switch room.type {
        case .Direct:
            array = [.transfer,
                     .paymentRequest,
            ]
        case .Group:
            array = [.paymentRequest,
            ]
        }
    }
    
    // UICollectionViewDelegate
    
    override public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let room = (viewController as? MessagesViewController)?.viewModel.room else {
            return
        }
        
        let item = array[indexPath.row]
        
        if room.type == .Direct {
            let roomMembers = room.members.filter({ $0.id != IMKit.uid })
            guard let uid = roomMembers.first?.id else { return }
            
            switch item {
            case .transfer:
            //kimuranow
//                IMManager.sharedInstance.handleEvent(event: .Transfer(uid: uid, roomID: room.id))
          
                break
            case .paymentRequest:
                var members = [[String:String]]()
                for member in roomMembers {
                    var info = [String:String]()
                    info["lpid"] = member.id
                    info["name"] = member.nickname
                    info["picUrl"] = member.avatarURL?.absoluteString ?? ""
                    members.append(info)
                }
            //kimuranow
//                IMManager.sharedInstance.handleEvent(event: .PaymentRequest(members: members, roomID: room.id, roomType: room.type.rawValue))
            }
        }
        else {
            let roomMembers = room.members
            
            switch item {
            case .transfer:
                break
           
            
            case .paymentRequest:
                var members = [[String:String]]()
                for member in roomMembers {
                    var info = [String:String]()
                    info["lpid"] = member.id
                    info["name"] = member.nickname
                    info["picUrl"] = member.avatarURL?.absoluteString ?? ""
                    members.append(info)
                }
            //kimuranow
//                IMManager.sharedInstance.handleEvent(event: .PaymentRequest(members: members, roomID: room.id, roomType: room.type.rawValue))
            }
        }
        
        //        let vc = ViewController()
        //        let nav = UINavigationController(rootViewController: vc)
        //        nav.modalPresentationStyle = .fullScreen
        //        (viewController as? IMMessagesViewController)?.inputBarViewController.keyboardType = .System
        //        (viewController as? IMMessagesViewController)?.inputBarViewController.resignAllFirstResponder()
        //        (viewController as? IMMessagesViewController)?.present(nav, animated: true, completion: nil)
    }
    
    // UICollectionViewDataSource
    
    override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // you can add extra data source for additional utilities
        setupUtilitiesIfNeeded()
        return array.count
    }
    
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IMUtilityCollectionViewCell", for: indexPath) as! IMUtilityCollectionViewCell
        cell.imageView.snp.remakeConstraints { make in
            make.width.height.equalTo(40)
            make.centerX.equalTo(cell.contentView)
            make.centerY.equalTo(cell.contentView).offset(-15)
        }
        cell.label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        cell.label.textColor = UIColor(red: 71 / 255, green: 71 / 255, blue: 71 / 255, alpha: 1)
        
        let item = array[indexPath.row]
        cell.imageView.image = item.image
        cell.label.text = item.title
        return cell
    }
    
    override public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = view.frame.width / 4
        return CGSize(width: size, height: 85)
    }
}
