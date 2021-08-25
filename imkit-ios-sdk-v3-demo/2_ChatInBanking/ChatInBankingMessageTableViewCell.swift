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
        iconImageView.contentMode = .scaleAspectFit
        return iconImageView
    }()
    
    lazy var contentLabel: UILabel = {
        let contentLabel = UILabel()
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
    
    lazy var sendTimeLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .lightGray
        lb.font = .demoApp400(size: 12.0)
        return lb
    }()
    
    override func setupUI(_ reuseIdentifier: String?) {
        super.setupUI(reuseIdentifier)

        let padding: CGFloat = 12.0
        bubbleView.addSubview(iconImageViewWrapper)
        iconImageViewWrapper.addSubview(iconImageView)
        bubbleView.addSubview(contentLabel)
        bubbleView.addSubview(detailButton)
        contentView.addSubview(sendTimeLabel)
        
        iconImageViewWrapper.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.height.equalTo(158.0)
            $0.leading.equalTo(timeLabel.snp.trailing)
        }
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(80.0)
        }
        contentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(padding)
            $0.top.equalTo(iconImageViewWrapper.snp.bottom).offset(padding)
            $0.height.greaterThanOrEqualTo(38.0)
        }
        detailButton.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(padding)
            $0.top.equalTo(contentLabel.snp.bottom).offset(padding)
        }
        sendTimeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.trailing.equalTo(bubbleView.snp.leading).offset(-6.0)
        }
        
        bubbleView.layer.borderColor = UIColor.clear.cgColor
        
        // add gap between cells
        bubbleView.snp.updateConstraints {
            $0.top.equalToSuperview().inset(6.0)
        }
    }
    func setupRedEnvelopType(_ type: ChatInBankingRedEnvelopType) {
        switch type {
        case .transfer:
            iconImageView.image = UIImage(named: "chatInBankingTransferMsgIcon")
            contentLabel.text = "You have transferred $1 on May 18, 2021 3:22 PM"
            break
        case .paymentReq:
            iconImageView.image = UIImage(named: "chatInBankingRequestMsgIcon")
            contentLabel.text = "You have sent a payment request on May 18, 2021 3:22 PM"
            break
        }
    }
    
    @objc func detailButtonTapped() {
        // TODO:
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

enum ChatInBankingRedEnvelopType {
    case transfer
    case paymentReq
}
