//
//  SampleListViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/22.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit
import IMKit
import PromiseKit

class SampleListViewController: UIViewController {

    var user: User?
    @IBOutlet weak var signoutButton: UIButton!
    private var selectedIndex: Int?
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        signoutButton.layer.cornerRadius = 28.0
        signoutButton.layer.borderWidth = 1.0
        signoutButton.layer.borderColor = UIColor(named: "themeColor")?.cgColor
        
        navigationController?.isNavigationBarHidden = true
        
        //kimuranow: dev routes
        IMKit.clear()
        
        IMFetchTokenTask().perform(uid: "sean135")
            .then({ token -> Promise<IMRoom> in
                IMKit.token = token
                IMKit.uid = "sean135"
                return IMCreateRoomTask().perform(
                    id: "room",   //kimuranow
                    name: "room"  //kimuranow
                )
            })
            .then({ room -> Promise<IMRoom> in
                return IMJoinRoomTask().perform(id: room.id)
            })
            .then({ room -> Promise<IMRoom> in
                return IMUpdateRoomTask().perform(
                    id: room.id,
                    
                    coverURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/3/34/Fallout_New_Vegas.jpg"),
                    description: "HELLO, WORLD"
                    
                )
            })
            .done({ room in
                let room = IMChatRoomViewController(roomID: room.id)
                // imkit-customized: 1. custom navigation bar color
                self.navigationController?.navigationBar.barTintColor = DemoScenarioType.tradingPlatform.subColor
                
                // imkit-customized: 整個聊天室背景
                IMStyle.messages.backgroundColor = .white
                IMStyle.messages.textCell.response.backgroundColor = .red
                
                IMStyle.navigationBar.tintColor = .black
                
                // imkit-customized: 對方的訊息泡泡
                IMStyle.messages.incomingCell.backgroundColor = DemoScenarioType.tradingPlatform.subColor
                // imkit-customized: 自己的訊息泡泡
                IMStyle.messages.outgoingCell.backgroundColor = UIColor(named: "tradingPlatformGrayColor")!
                
                room.inputBarView.sendButton.setImage(UIImage(named: "tradingPlatformSend"), for: .normal)
                room.inputBarView.imageButton.setImage(UIImage(named: "tradingPlatformImage"), for: .normal)
                room.inputBarView.cameraButton.setImage(UIImage(named: "tradingPlatformCamera"), for: .normal)
                
                
                
                self.navigationController?.pushViewController(room, animated: true)
            })
            .catch({ error in
                print(error)
            })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func sampleButton1Pressed(_ sender: UIButton) {
        selectedScenario(index: 0)
    }
    @IBAction func sampleButton2Pressed(_ sender: UIButton) {
        selectedScenario(index: 1)
    }
    @IBAction func sampleButton3Pressed(_ sender: UIButton) {
        selectedScenario(index: 2)
    }
    @IBAction func sampleButton4Pressed(_ sender: UIButton) {
        selectedScenario(index: 3)
    }
    @IBAction func signOutButtonPressed(_ sender: UIButton) {
    }
    
    func selectedScenario(index: Int) {
        selectedIndex = index
        performSegue(withIdentifier: "goScenarioIntro", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = selectedIndex else { return }
        guard let vc = segue.destination as? ScenarioIntroViewController else { return }
        vc.model = scenarioIntroDtos()[selectedIndex]
        vc.user = user
    }
}

private extension SampleListViewController {
    func scenarioIntroDtos() -> [ScenarioIntroDto] {
        [
            ScenarioIntroDto(
                type: .tradingPlatform,
                title: "Trading platform",
                content: """
            1. custom navigation bar color
            2. custom 訊息泡泡框顏色
            3. 聊天室入框上方警語
            """
            ),
            ScenarioIntroDto(
                type: .chatInBanking,
                title: "Chat in banking",
                content: """
                        1. 官方帳號聊天室
                        2. custom 訊息泡泡框顏色邊框
                        3. custom message type
            
            
            """
            ),
            ScenarioIntroDto(
                type: .networkingChat,
                title: "Networking chat",
                content: """
                        1. custom navigation bar 內容
                        2. custom 訊息泡泡框形狀
            """
            ),
            ScenarioIntroDto(
                type: .businessChat,
                title: "Business chat",
                content: """
                1. Search bar
                2. Folder
                3. Tag
                4. custom menu item （按＋之後顯示的選單按鈕們）
                5. 訊息動作（複製、收回、轉傳、回覆）
                6. 翻譯功能（請在這邊顯示預設開）
            """
            ),
        ]
    }
    
}

struct ScenarioIntroDto {
    let type: DemoScenarioType
    let title: String
    let content: String
}

enum DemoScenarioType {
    case tradingPlatform
    case chatInBanking
    case networkingChat
    case businessChat
    
    var themeColor: UIColor {
        switch self {
        case .tradingPlatform:
            return UIColor(named: "tradingPlatformThemeColor")!
            break
        case .chatInBanking:
            return .red
        case .networkingChat:
            return .red
        case .businessChat:
            return .red
        }
    }
    var subColor: UIColor {
        switch self {
        case .tradingPlatform:
            return UIColor(named: "tradingPlatformSubColor")!           
        case .chatInBanking:
            return .red
        case .networkingChat:
            return .red
        case .businessChat:
            return .red
        }
    }
}
