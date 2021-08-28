//
//  BusinessChatScenarioChatRoomViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/6.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import IMKit

class BusinessChatScenarioChatRoomViewController: IMChatRoomViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // text-color of title on navibar
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        // background-color of navibar
        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#02B13F")
        // back-button-tint-color of navibar
        navigationController?.navigationBar.tintColor = .white

        // imkit-customized: 對方的訊息泡泡
//        IMStyle.messages.incomingCell.backgroundColor = UIColor(hexString: "#F2F9FF")!
        // imkit-customized: 自己的訊息泡泡
//        IMStyle.messages.outgoingCell.backgroundColor = UIColor(hexString: "#5BBFED")!
//        IMStyle.messages.outgoingCell.textColor = .white
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // restore
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
    }
}
