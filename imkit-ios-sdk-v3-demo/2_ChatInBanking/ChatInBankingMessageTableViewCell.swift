//
//  ChatInBankingMessageTableViewCell.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/8.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import IMKit
import SnapKit

class ChatInBankingMessageTableViewCell: IMMessageTableViewCell {
    
    lazy var iconImageViewWrapper: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "FEFCD7")
        return view
    }()
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "chatInBankingRequestMsgIcon")
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.text = "You have sent a payment request on May 18, 2021 3:22 PM" //kimuranow
        contentLabel.font = .demoApp400(size: 14.0)
        contentLabel.numberOfLines = 0
        return contentLabel
    }()
    
    lazy var detailButton: UIButton = {
        let detailButton = UIButton()
        detailButton.setTitle("View records", for: .normal)
        detailButton.titleLabel?.font = .demoApp800(size: 14.0)
        detailButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
        detailButton.setTitleColor(UIColor(hexString: "#E476B2"), for: .normal)
        return detailButton
    }()
    
    override func setupUI(_ reuseIdentifier: String?) {
        super.setupUI(reuseIdentifier)
        if let reuseId = reuseIdentifier {
            if reuseId.starts(with: "Incoming") {
                
            } else if reuseId.starts(with: "Outgoing") {
                
            }
        }
        let padding: CGFloat = 12.0
        bubbleView.addSubview(iconImageViewWrapper)
        iconImageViewWrapper.addSubview(iconImageView)
        bubbleView.addSubview(contentLabel)
        bubbleView.addSubview(detailButton)
        
        iconImageViewWrapper.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(158.0) //kimuranow
        }
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(80.0)
        }
        contentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.top.equalTo(iconImageViewWrapper.snp.bottom).offset(padding)
            $0.height.greaterThanOrEqualTo(38.0) //kimuranow
        }
        detailButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(padding)
            $0.top.equalTo(contentLabel.snp.bottom).offset(padding)
        }
        bubbleView.layer.borderColor = UIColor.clear.cgColor
    }
    override func updateUI() {
        super.updateUI()
    }
    
    @objc func detailButtonTapped() {
        //kimuranow
    }
}

class ChatInBankingMessageTableViewCellOutgoing: ChatInBankingMessageTableViewCell {
    
    override func setupUI(_ reuseIdentifier: String?) {
        super.setupUI(reuseIdentifier)
    }
}


extension UIFont {
    static func demoApp400(size: CGFloat) -> UIFont {
        UIFont(name: "Nunito-Regular", size: size)!
    }
    static func demoApp600(size: CGFloat) -> UIFont {
        UIFont(name: "Nunito-SemiBold", size: size)!
    }
    static func demoApp800(size: CGFloat) -> UIFont {
        UIFont(name: "Nunito-ExtraBold", size: size)!
    }
}
