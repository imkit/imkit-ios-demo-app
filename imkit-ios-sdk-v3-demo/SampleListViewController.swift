//
//  SampleListViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/22.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit

class SampleListViewController: UIViewController {

    var user: User?
    @IBOutlet weak var signoutButton: UIButton!
    @IBOutlet weak var sceneTitleLabel: UILabel!
    @IBOutlet weak var sdkVersionLabel: UILabel!
    @IBOutlet weak var scenario1TitleLabel: UILabel!
    @IBOutlet weak var scenario2TitleLabel: UILabel!
    @IBOutlet weak var scenario3TitleLabel: UILabel!
    @IBOutlet weak var scenario4TitleLabel: UILabel!
    
    private var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signoutButton.setTitle("SampleListViewController_signout_button_title".localized, for: .normal)
        sceneTitleLabel.text = "SampleListViewController_title".localized
        sdkVersionLabel.text = "SampleListViewController_sdk_version_title".localized //kimuranow
        scenario1TitleLabel.text = "SampleListViewController_trading_platform_scenario_title".localized
        scenario2TitleLabel.text = "SampleListViewController_chat_in_banking_scenario_title".localized
        scenario3TitleLabel.text = "SampleListViewController_networking_chat_scenario_title".localized
        scenario4TitleLabel.text = "SampleListViewController_business_chat_scenario_title".localized
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
        //kimuranow
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
                content: "ScenarioIntroViewController_trading_platform_description".localized
            ),
            ScenarioIntroDto(
                type: .chatInBanking,
                title: "Chat in banking",
                content: "ScenarioIntroViewController_chat_in_banking_description".localized
            ),
            ScenarioIntroDto(
                type: .networkingChat,
                title: "Networking chat",
                content: "ScenarioIntroViewController_networking_chat_description".localized
            ),
            ScenarioIntroDto(
                type: .businessChat,
                title: "Business chat",
                content: "ScenarioIntroViewController_business_chat_description".localized
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

