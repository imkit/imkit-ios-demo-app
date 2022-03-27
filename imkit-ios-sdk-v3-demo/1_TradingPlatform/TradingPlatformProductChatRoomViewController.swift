//
//  TradingPlatformProductChatRoomViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/6.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import IMKit
import UIKit

class TradingPlatformProductChatRoomViewController: IMChatRoomViewController {
    
    //MARK: - Properties
    private let productView: ProductView = Bundle.main.loadNibNamed("\(ProductView.self)", owner: self, options: nil)?.first as! ProductView
    private let productStatusImageView: UIImageView = UIImageView(image: UIImage(named: "icon_arrow_down"))
    private let product: Product
    private var defaultIMStyleMsgBgColor: UIColor?
    
    //MARK: - Life Cycle
    init(product: Product, roomID: String) {
        self.product = product
        super.init(roomID: roomID)
    }
    
    @objc required dynamic init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        defaultIMStyleMsgBgColor = IMStyle.messages.backgroundColor
        // imkit-customized: 整個聊天室背景
        IMStyle.messages.backgroundColor = .clear // background-color of cell
        IMStyle.messages.inputAccessory.isSendButtonAudioButtonCombined = false
        
        // imkit-customized: 對方的訊息泡泡
        IMStyle.messages.incomingCell.backgroundColor = DemoScenarioType.tradingPlatform.subColor
        // imkit-customized: 自己的訊息泡泡
        IMStyle.messages.outgoingCell.backgroundColor = UIColor(named: "tradingPlatformGrayColor")!
        
        inputBarView = TradingPlatformInputAccessoryView()
        inputBarView.viewController = self
        
        setupSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.backgroundColor = .white
        // imkit-customized: 1. custom navigation bar color
        navigationController?.navigationBar.barTintColor = DemoScenarioType.tradingPlatform.subColor
        navigationController?.navigationBar.tintColor = .black

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // restore
        IMStyle.messages.inputAccessory.isSendButtonAudioButtonCombined = true
        if let bgColor = defaultIMStyleMsgBgColor {
            IMStyle.messages.backgroundColor = bgColor
        }
    }
    
    override func titleViewTapped() {
        super.titleViewTapped()
        productView.isHidden.toggle()
        productStatusImageView.image = UIImage(named: productView.isHidden ? "icon_arrow_up" : "icon_arrow_down")
    }
}
// MARK: - Private

private extension TradingPlatformProductChatRoomViewController {

    func setupSubviews() {
        productView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(productView)
        
        productView.topAnchor.constraint(equalTo: view.topAnchor, constant: topbarHeight).isActive = true
        productView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        productView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        productView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        productView.configure(product: product)
        
        stackView.addArrangedSubview(productStatusImageView)
    }
}
