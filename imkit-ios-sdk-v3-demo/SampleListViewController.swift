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
        
//        goChatInBankingScenarioChatroomList()
//        goNetworkingChatScenarioChatroomList()
        goBusinessChatScenarioChatroomList()
    }
    
    
   
    func textView() -> UIView {
        let v = UIView()
        let label = UILabel()
        label.text = "FOOBAR"
        label.textColor = .blue
        v.addSubview(label)
        return v
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
        case .chatInBanking:
            return UIColor(hexString: "F178B6")!
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
            return UIColor(hexString: "FFDEF0")!
        case .networkingChat:
            return .red
        case .businessChat:
            return .red
        }
    }
}

extension UIColor {
  convenience init?(hexString hex: String) {
    var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if cString.hasPrefix("#") {
      cString.remove(at: cString.startIndex)
    }

    guard cString.count == 6 else {
      return nil
    }

    var rgbValue: UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    self.init(
      red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
      alpha: CGFloat(1.0)
    )
  }
}
extension SampleListViewController {
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
