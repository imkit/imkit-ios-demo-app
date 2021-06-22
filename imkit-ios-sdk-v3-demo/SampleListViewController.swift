//
//  SampleListViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/22.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit

class SampleListViewController: UIViewController {

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
    }
}

private extension SampleListViewController {
    func scenarioIntroDtos() -> [ScenarioIntroDto] {
        [
            ScenarioIntroDto(
                title: "Trading platform",
                content: """
            1. custom navigation bar color
            2. custom 訊息泡泡框顏色
            3. 聊天室入框上方警語
            """
            ),
            ScenarioIntroDto(
                title: "Chat in banking",
                content: """
                        1. 官方帳號聊天室
                        2. custom 訊息泡泡框顏色邊框
                        3. custom message type
            
            
            """
            ),
            ScenarioIntroDto(
                title: "Networking chat",
                content: """
                        1. custom navigation bar 內容
                        2. custom 訊息泡泡框形狀
            """
            ),
            ScenarioIntroDto(
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
    let title: String
    let content: String
}
