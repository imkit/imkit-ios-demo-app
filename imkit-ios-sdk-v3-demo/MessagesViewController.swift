//
//  MessagesViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Howard Sun on 2019/10/27.
//  Copyright © 2019 Howard Sun. All rights reserved.
//

import Foundation
import IMKit

class MessagesViewController: IMMessagesViewController {
    
    lazy var utilityInputVC: UtilityInputViewController = {
        let vc = UtilityInputViewController()
        vc.viewController = self
        return vc
    }()
    
    override var utilityInputViewController: IMUtilityInputViewController {
        get {
            return utilityInputVC
        }
        set {}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IMTextMessageCollectionViewCell.urlTapHandler = { url in
            UIApplication.shared.open(url)
        }
    }
    
    override func avatarDidTapped(user: IMUser) {
        
    }
}

