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
    lazy var showRecordButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(named: "chatInBankingShowRecordButtonIcon"), style: .done, target: self, action: #selector(showRecordButtonTapped))
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        IMStyle.messages.backgroundColor = UIColor(hexString: "FFF6FB")!
        IMStyle.messages.inputAccessory.isSendButtonAudioButtonCombined = false
        
        inputBarView = ChatInBankingInputAccessoryView()
        let chatInBankingUtilityInputViewController = ChatInBankingUtilityInputViewController()
        chatInBankingUtilityInputViewController.transferButtonAction = { [weak self] in
            guard let self = self else { return }
            let msg = IMMessage(
                from: [
                    "_id": UUID().uuidString,
                    "messageType": "transfer",
                    "room": self.viewModel.roomID,
                    "sender": ["_id": "sean111"],
                    "createdAtMS": Date().timeIntervalSince1970,
                    "extraString": 199 // money
                ]
            )
            msg.status = .delivered
            self.viewModel.messageDidAdd(
                message: msg
            )
        }
        chatInBankingUtilityInputViewController.paymentRequestButtonAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel.messageDidAdd(
                message:
                    IMMessage(
                        from: [
                            "_id": UUID().uuidString,
                            "messageType": "paymentRequest",
                            "room": self.viewModel.roomID,
                            "sender": ["_id": "sean111"],
                            "createdAtMS": Date().timeIntervalSince1970,
                            "extraString": 199 // money
                        ]
                    )
            )
        }
        utilityInputViewController = chatInBankingUtilityInputViewController
        
        tableView.register(ChatInBankingMessageTableViewCell.self, forCellReuseIdentifier: "ChatInBankingMessageTableViewCell")
        tableView.register(ChatInBankingMessageTableViewCellOutgoing.self, forCellReuseIdentifier: "OutgoingChatInBankingMessageTableViewCellOutgoing")
//        tableView.register(ChatInBankingMessageTableViewCellOutgoing.self, forCellReuseIdentifier: "OutgoingChatInBankingMessageTableViewCellOutgoing")
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = UIColor(hexString: "#F178B6")
//        navigationController?.navigationBar.barTintColor = UIColor(hexString: "#F178B6")
        
        // text-color of title on navibar
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(hexString: "#F178B6")!]
        navigationItem.rightBarButtonItem = showRecordButton
        
        

        // imkit-customized: 對方的訊息泡泡
        IMStyle.messages.incomingCell.backgroundColor = DemoScenarioType.chatInBanking.subColor
        // imkit-customized: 自己的訊息泡泡
        IMStyle.messages.outgoingCell.backgroundColor = .white
        IMStyle.messages.outgoingCell.borderColor = DemoScenarioType.chatInBanking.themeColor
        IMStyle.messages.outgoingCell.borderWidth = 1.0
        IMStyle.messages.outgoingCell.isBorderHidden = false

        tableView.backgroundColor = UIColor(hexString: "FFF6FB")!
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // mock message
        self.viewModel.messageDidAdd(
            message:
                IMMessage(
                    from: [
                        "_id": UUID().uuidString,
                        "messageType": "transfer",
                        "room": self.viewModel.roomID,
                        "sender": ["_id": "sean111"],
                        "createdAtMS": 1625678468,
                        "extraString": 199 // money
                    ]
                )
        )
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // restore
        IMStyle.messages.outgoingCell.backgroundColor = .white
        IMStyle.messages.outgoingCell.borderColor = .clear
        IMStyle.messages.outgoingCell.borderWidth = 1.0
        IMStyle.messages.outgoingCell.isBorderHidden = true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.sections[indexPath.section][indexPath.row].messageType == "transfer" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingChatInBankingMessageTableViewCellOutgoing", for: indexPath) as! ChatInBankingMessageTableViewCellOutgoing
            return cell
        } else if viewModel.sections[indexPath.section][indexPath.row].messageType == "paymentRequest" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingChatInBankingMessageTableViewCellOutgoing", for: indexPath) as! ChatInBankingMessageTableViewCellOutgoing
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}

extension ChatInBankingChatRoomViewController {
    @objc func showRecordButtonTapped() {
        self.navigationController?.pushViewController(ChatInBankingRecordListViewController(), animated: true)
    }
}
