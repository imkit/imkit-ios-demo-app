//
//  ChatInBankingChatRoomViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/6.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import IMKit

class ChatInBankingChatRoomViewController: IMChatRoomViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        IMStyle.messages.backgroundColor = UIColor(hexString: "FFF6FB")!
        IMStyle.messages.inputAccessory.isSendButtonAudioButtonCombined = false
        
        inputBarView = ChatInBankingInputAccessoryView()
        utilityInputViewController = ChatInBankingUtilityInputViewController()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barTintColor = .white

        // imkit-customized: 對方的訊息泡泡
        IMStyle.messages.incomingCell.backgroundColor = DemoScenarioType.chatInBanking.subColor
        // imkit-customized: 自己的訊息泡泡
        IMStyle.messages.outgoingCell.backgroundColor = .white
        IMStyle.messages.outgoingCell.borderColor = .blue // DemoScenarioType.chatInBanking.themeColor
        IMStyle.messages.outgoingCell.borderWidth = 1.0
        IMStyle.messages.outgoingCell.isBorderHidden = false
                                        
        tableView.backgroundColor = UIColor(hexString: "FFF6FB")!                
    }
}
