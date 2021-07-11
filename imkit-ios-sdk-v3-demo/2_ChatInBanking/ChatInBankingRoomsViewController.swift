//
//  ChatInBankingRoomsViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/6.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import IMKit

class ChatInBankingRoomsViewController: IMRoomsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chat in banking"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        folderButton.isHidden = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func didSelectRoom(room: IMRoom) {
//        super.didSelectRoom(room: room)
        
        let room = ChatInBankingChatRoomViewController(roomID: room.id)
        navigationController?.pushViewController(room, animated: true)
    }
}
