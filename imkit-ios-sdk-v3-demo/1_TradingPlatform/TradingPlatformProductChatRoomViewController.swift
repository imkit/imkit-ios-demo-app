//
//  TradingPlatformProductChatRoomViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/6.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import IMKit

class TradingPlatformProductChatRoomViewController: IMChatRoomViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // imkit-customized: 1. custom navigation bar color
        navigationController?.navigationBar.barTintColor = DemoScenarioType.tradingPlatform.subColor
        navigationController?.navigationBar.tintColor = .black
        // imkit-customized: 整個聊天室背景
        IMStyle.messages.backgroundColor = .white
        IMStyle.messages.textCell.response.backgroundColor = .red
        
        // imkit-customized: 對方的訊息泡泡
        IMStyle.messages.incomingCell.backgroundColor = DemoScenarioType.tradingPlatform.subColor
        // imkit-customized: 自己的訊息泡泡
        IMStyle.messages.outgoingCell.backgroundColor = UIColor(named: "tradingPlatformGrayColor")!
        
        inputBarView.sendButton.setImage(UIImage(named: "tradingPlatformSend"), for: .normal)
        inputBarView.imageButton.setImage(UIImage(named: "tradingPlatformImage"), for: .normal)
        inputBarView.cameraButton.setImage(UIImage(named: "tradingPlatformCamera"), for: .normal)
        inputBarView.addButton.isHidden = true
        inputBarView.audioButton.isHidden = true
        inputBarView.stickerButton.isHidden = true
        
    }
}
