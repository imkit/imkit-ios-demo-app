//
//  TradingPlatformProductViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/23.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit
import IMKit
import PromiseKit
import ProgressHUD

class TradingPlatformProductViewController: UIViewController {
    
    
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDescLabel: UILabel!    
    @IBOutlet weak var goChatroomButton: UIButton!
    
    var user: User?
    var navBarDefaultColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TradingPlatformProductViewController_title".localized
        navBarDefaultColor = navigationController?.navigationBar.tintColor
        
        productTitleLabel.text = "TradingPlatformProductViewController_mock_product_title".localized
        productPriceLabel.text = "TradingPlatformProductViewController_mock_product_price".localized
        productDescLabel.text = "TradingPlatformProductViewController_mock_product_description".localized
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = navBarDefaultColor
    }
    @IBAction func chatButtonPressed(_ sender: UIButton) {
        guard let user = user else { return }
        
        goChatroomButton.isEnabled = false
        ProgressHUD.show()
        IMKit.clear()
        
        IMKit.connect(uid: user.uuid)
            .then({ result -> Promise<IMUser> in
                return IMUpdateMyProfileTask().perform(nickname: user.nickname, avatarURL: nil, description: nil)
            })
            .then({ user -> Promise<IMRoom> in
                return IMCreateDirectChatTask().perform(invitee: "trading_platform_id")
            })
            .done({ [weak self] room in
                ProgressHUD.dismiss()
                self?.navigationController?.pushViewController(
                    TradingPlatformProductChatRoomViewController(roomID: room.id),
                    animated: true
                )
                self?.goChatroomButton.isEnabled = true
            })
            .catch({ [weak self] error in
                ProgressHUD.dismiss()
                self?.goChatroomButton.isEnabled = true
                print(error)
            })
    }
}
