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
    private var hasStartButtonBeenPressed: Bool = false
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.setTitle("ScenarioIntroViewController_start_button_title".localized, for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        IMRoomsViewController.searchBarEnabled = false
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
        guard !hasStartButtonBeenPressed else {
            return
        }
        hasStartButtonBeenPressed = true
        
        switch model.type {
        case .tradingPlatform:
            performSegue(withIdentifier: "goTradingPlatform", sender: nil)
            hasStartButtonBeenPressed = false
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
        IMKit.connect(uid: normalizedUserId)
        .then { result -> Promise<IMUser> in
            return IMUpdateMyProfileTask().perform(nickname: user.nickname, avatarURL: nil, description: nil)
        }.then { user -> Promise<[IMRoom]> in
            return when(fulfilled: [
                IMCreateDirectChatTask().perform(invitee: User.mockUserCoco.uuid),
                IMCreateDirectChatTask().perform(invitee: User.mockUserLora.uuid),
                IMCreateDirectChatTask().perform(invitee: User.mockUserCharle.uuid),
                IMCreateDirectChatTask().perform(invitee: "official_account_id")
            ])
        }.done { rooms in
            let rooms = ChatInBankingRoomsViewController()
            self.navigationController?.pushViewController(rooms, animated: true)
            self.hasStartButtonBeenPressed = false
        }.catch { error in
            print(error)
            self.hasStartButtonBeenPressed = false
        }
    }
    func goNetworkingChatScenarioChatroomList() {
        guard let user = user else { return }
        let normalizedUserId: String = "\(user.uuid)networkingChat"
        IMKit.clear()
        IMKit.connect(uid: normalizedUserId)
        .then { result -> Promise<IMUser> in
            return IMUpdateMyProfileTask().perform(nickname: user.nickname, avatarURL: nil, description: nil)
        }
        .then { user -> Promise<[IMRoom]> in
            return when(fulfilled: [
                IMCreateDirectChatTask().perform(invitee: User.mockUserCoco.uuid),
            ])
        }.done { rooms in
            let rooms = NetworkingChatScenarioRoomsViewController()
            self.navigationController?.pushViewController(rooms, animated: true)
            self.hasStartButtonBeenPressed = false
        }.catch { error in
            print(error)
            self.hasStartButtonBeenPressed = false
        }
    }
    func goBusinessChatScenarioChatroomList() {        
        guard let user = user else { return }
        let normalizedUserId: String = "\(user.uuid)businessChat"
        IMKit.clear()
        IMKit.connect(uid: normalizedUserId)
        .then { result -> Promise<IMUser> in
            return IMUpdateMyProfileTask().perform(nickname: user.nickname, avatarURL: nil, description: nil)
        }
        .then { user -> Promise<[IMRoom]> in
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
            IMRoomsViewController.searchBarEnabled = true
            let rooms = BusinessChatScenarioRoomsViewController()
            self.navigationController?.pushViewController(rooms, animated: true)
            self.hasStartButtonBeenPressed = false
        }.catch { error in
            print(error)
            self.hasStartButtonBeenPressed = false
        }
    }
}
