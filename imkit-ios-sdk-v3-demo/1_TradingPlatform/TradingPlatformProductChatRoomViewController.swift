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
        IMStyle.messages.backgroundColor = .clear // background-color of cell
        IMStyle.messages.inputAccessory.isSendButtonAudioButtonCombined = false
        
        // imkit-customized: 對方的訊息泡泡
        IMStyle.messages.incomingCell.backgroundColor = DemoScenarioType.tradingPlatform.subColor
        // imkit-customized: 自己的訊息泡泡
        IMStyle.messages.outgoingCell.backgroundColor = UIColor(named: "tradingPlatformGrayColor")!
        
        inputBarView = TradingPlatformInputAccessoryView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.backgroundColor = .white
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // restore
        IMStyle.messages.inputAccessory.isSendButtonAudioButtonCombined = true
    }
}
