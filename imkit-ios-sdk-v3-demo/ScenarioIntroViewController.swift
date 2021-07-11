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
        IMKit.clear()
        IMFetchTokenTask().perform(uid: "sean111", nickname: "sean")
            .then { token -> Promise<[IMRoom]> in
                IMKit.token = token
                IMKit.uid = "sean111"
                return when(fulfilled: [
                    IMCreateDirectChatTask().perform(invitee: "coco_id"),
                    IMCreateDirectChatTask().perform(invitee: "lora_id"),
                    IMCreateDirectChatTask().perform(invitee: "charle_id")
                ])
            }.done { rooms in
                let rooms = ChatInBankingRoomsViewController()
                self.navigationController?.pushViewController(rooms, animated: true)
            }.catch { error in
                print(error)
            }
    }
    func goNetworkingChatScenarioChatroomList() {
        IMKit.clear()
        IMFetchTokenTask().perform(uid: "sean135Networking", nickname: "sean135")
            .then { token -> Promise<[IMRoom]> in
                IMKit.token = token
                IMKit.uid = "sean135Networking"
                return when(fulfilled: [
                    IMCreateDirectChatTask().perform(invitee: "coco_id"),
                    //                    IMCreateDirectChatTask().perform(invitee: "lora_id"),
                    //                    IMCreateDirectChatTask().perform(invitee: "charle_id")
                ])
            }.done { rooms in
                let rooms = NetworkingChatScenarioRoomsViewController()
                self.navigationController?.pushViewController(rooms, animated: true)
            }.catch { error in
                print(error)
            }
    }
    func goBusinessChatScenarioChatroomList() {
        IMKit.clear()
        IMFetchTokenTask().perform(uid: "sean135Business", nickname: "sean")
            .then { token -> Promise<[IMRoom]> in
                IMKit.token = token
                IMKit.uid = "sean135Business"
                return when(fulfilled: [
                    IMCreateDirectChatTask().perform(invitee: "coco_id"),
                    IMCreateDirectChatTask().perform(invitee: "lora_id"),
                    IMCreateDirectChatTask().perform(invitee: "charle_id")
                ])
            }.done { rooms in
                let rooms = BusinessChatScenarioRoomsViewController()
                self.navigationController?.pushViewController(rooms, animated: true)
            }.catch { error in
                print(error)
            }
    }
}
