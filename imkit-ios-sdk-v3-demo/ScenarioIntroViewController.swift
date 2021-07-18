//
//  ScenarioIntroViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/22.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit
import IMKit
import PromiseKit

class ScenarioIntroViewController: UIViewController {

    var model: ScenarioIntroDto?
    var user: User?
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startButton.layer.cornerRadius = startButton.bounds.height / 2.0
        if let model = model {
            title = model.title
            contentTextView.text = model.content
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TradingPlatformProductViewController {
            vc.user = user
        }
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        guard let model = model else { return }
        switch model.type {
        case .tradingPlatform:
            performSegue(withIdentifier: "goTradingPlatform", sender: nil)
            break
        case .chatInBanking:
            goChatInBankingScenarioChatroomList()
            break
        case .networkingChat:
            goNetworkingChatScenarioChatroomList()
            break
        case .businessChat:
            goBusinessChatScenarioChatroomList()
            break
        }
    }
}
extension ScenarioIntroViewController {
    func goChatInBankingScenarioChatroomList() {
        guard let user = user else { return }
        let normalizedUserId: String = "\(user.uuid)chatInBanking"
        IMKit.clear()
        IMFetchTokenTask().perform(
            uid: normalizedUserId,
            nickname: user.nickname
        )
        .then { token -> Promise<[IMRoom]> in
            IMKit.token = token
            IMKit.uid = normalizedUserId
            return when(fulfilled: [
                IMCreateDirectChatTask().perform(invitee: User.mockUserCoco.uuid),
                IMCreateDirectChatTask().perform(invitee: User.mockUserLora.uuid),
                IMCreateDirectChatTask().perform(invitee: User.mockUserCharle.uuid),
                IMCreateDirectChatTask().perform(invitee: "official_account_id")
            ])
        }.done { rooms in
            let rooms = ChatInBankingRoomsViewController()
            self.navigationController?.pushViewController(rooms, animated: true)
        }.catch { error in
            print(error)
        }
    }
    func goNetworkingChatScenarioChatroomList() {
        guard let user = user else { return }
        let normalizedUserId: String = "\(user.uuid)networkingChat"
        IMKit.clear()
        IMFetchTokenTask().perform(
            uid: normalizedUserId,
            nickname: user.nickname
        )
        .then { token -> Promise<[IMRoom]> in
            IMKit.token = token
            IMKit.uid = normalizedUserId
            return when(fulfilled: [
                IMCreateDirectChatTask().perform(invitee: User.mockUserCoco.uuid),
//                IMCreateDirectChatTask().perform(invitee: User.mockUserLora.uuid),
//                IMCreateDirectChatTask().perform(invitee: User.mockUserCharle.uuid)
            ])
        }.done { rooms in
            let rooms = NetworkingChatScenarioRoomsViewController()
            self.navigationController?.pushViewController(rooms, animated: true)
        }.catch { error in
            print(error)
        }
    }
    func goBusinessChatScenarioChatroomList() {
        guard let user = user else { return }
        let normalizedUserId: String = "\(user.uuid)businessChat"
        IMKit.clear()
        IMFetchTokenTask().perform(
            uid: normalizedUserId,
            nickname: user.nickname
        )
        .then { token -> Promise<[IMRoom]> in
            IMKit.token = token
            IMKit.uid = normalizedUserId
            return when(fulfilled: [
                IMCreateDirectChatTask().perform(invitee: User.mockUserCoco.uuid),
                IMCreateDirectChatTask().perform(invitee: User.mockUserLora.uuid),
                IMCreateDirectChatTask().perform(invitee: User.mockUserCharle.uuid)
            ])
        }
        .then { rooms -> Promise<IMRoom> in
            return IMCreateGroupChatTask().perform(
                roomID: "fixedGroupChat",
                roomName: "Shopping Group",
                invitees: [user.uuid, User.mockUserCoco.uuid, User.mockUserLora.uuid, User.mockUserCharle.uuid],
                isSystemMessageEnabled: false,
                needsInvitation: false
            )
        }.done { _ in
            let rooms = BusinessChatScenarioRoomsViewController()
            self.navigationController?.pushViewController(rooms, animated: true)
        }.catch { error in
            print(error)
        }
    }
}
