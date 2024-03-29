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
    
    /*
     More detail please checking comments in `ViewDidLoad` method of this file.
     */
    private lazy var chatInBankingUtilityInputViewController: ChatInBankingUtilityInputViewController = {
        let chatInBankingUtilityInputViewController = ChatInBankingUtilityInputViewController()
        chatInBankingUtilityInputViewController.transferButtonAction = { [weak self] in
            guard let self = self else { return }
            let msg = IMMessage(
                from: [
                    "_id": UUID().uuidString,
                    "message": "您已成功轉帳。",
                    "messageType": "transfer",
                    "room": self.viewModel.roomID,
                    "sender": ["_id": "sean111"], //kimuranow
                    "createdAtMS": Date().timeIntervalSince1970,
                    "extraString": "{ \"money\": 199}"
                ]
            )
            let params: [String: String] = [
                "messageType": "transfer",
                "message": "您已成功轉帳。",
                "extra": "{ \"money\": 199}"
            ]
            msg.status = .undelivered
            IMMessagesManager.shared.sendMessage(
                message: msg,
                parameters: params
            )
        }
        chatInBankingUtilityInputViewController.paymentRequestButtonAction = { [weak self] in
            guard let self = self else { return }
            let msg = IMMessage(
                from: [
                    "_id": UUID().uuidString,
                    "message": "您已發出轉帳要求。",
                    "messageType": "paymentRequest",
                    "room": self.viewModel.roomID,
                    "sender": ["_id": "sean111"], //kimuranow
                    "createdAtMS": Date().timeIntervalSince1970,
                    "extraString": "{ \"money\": 199}"
                ]
            )
            let params: [String: String] = [
                "messageType": "paymentRequest",
                "message": "您已發出轉帳要求。",
                "extra": "{ \"money\": 199}"
            ]
            msg.status = .undelivered
            IMMessagesManager.shared.sendMessage(
                message: msg,
                parameters: params
            )
        }
        return chatInBankingUtilityInputViewController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        IMStyle.messages.backgroundColor = UIColor(hexString: "FFF6FB")!
        IMStyle.messages.inputAccessory.isSendButtonAudioButtonCombined = false
        
        inputBarView = ChatInBankingInputAccessoryView()
        
        /*
             utilityInputViewController is a property of IMChatRoomViewController to indicating more
         functional buttons for chatting in IMKIT. If you try to customize it, just create a new
         ViewController to inherented from `IMUtilityInputViewController`, and set it to this property.
         It will be overrided for your customization. For this case, we demo a `ChatInBankingUtilityInputViewController`
         for you which is setup as private variable as coded below in Line 17 in this file.
         
             More detail please checking `ChatInBankingUtilityInputViewController` swift file.
         */
        utilityInputViewController = chatInBankingUtilityInputViewController
        
        tableView.register(ChatInBankingMessageTableViewCell.self, forCellReuseIdentifier: "ChatInBankingMessageTableViewCell")
        tableView.register(ChatInBankingMessageTableViewCellOutgoing.self, forCellReuseIdentifier: "OutgoingChatInBankingMessageTableViewCellOutgoing")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = UIColor(hexString: "#F178B6")
        
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
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // restore
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
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
        
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"

        if viewModel.sections[indexPath.section][indexPath.row].messageType == "transfer" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingChatInBankingMessageTableViewCellOutgoing", for: indexPath) as! ChatInBankingMessageTableViewCellOutgoing
            cell.setupRedEnvelopType(.transfer)
            cell.sendTimeLabel.text = formatter.string(from: viewModel.sections[indexPath.section][indexPath.row].createTime)
            return cell
        } else if viewModel.sections[indexPath.section][indexPath.row].messageType == "paymentRequest" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingChatInBankingMessageTableViewCellOutgoing", for: indexPath) as! ChatInBankingMessageTableViewCellOutgoing
            cell.setupRedEnvelopType(.paymentReq)
            
            cell.sendTimeLabel.text = formatter.string(from: viewModel.sections[indexPath.section][indexPath.row].createTime)
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    @objc func showRecordButtonTapped() {
        self.navigationController?.pushViewController(ChatInBankingRecordListViewController(), animated: true)
    }
}
