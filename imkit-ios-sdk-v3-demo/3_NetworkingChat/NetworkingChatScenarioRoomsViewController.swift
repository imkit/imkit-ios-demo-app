//
//  NetworkingChatScenarioRoomsViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/6.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import IMKit

class NetworkingChatScenarioRoomsViewController: IMRoomsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ScenarioIntroViewController_networking_chat_title".localized
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        folderButton.isHidden = true
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .black
    }
    func didSelectRoom(room: IMRoom) {
        let room = NetworkingChatScenarioChatRoomViewController(roomID: room.id)
        navigationController?.pushViewController(room, animated: true)
    }
}
