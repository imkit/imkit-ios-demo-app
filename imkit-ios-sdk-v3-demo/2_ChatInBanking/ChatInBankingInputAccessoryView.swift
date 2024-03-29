//
//  ChatInBankingInputAccessoryView.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/6.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import IMKit
import SnapKit

class ChatInBankingInputAccessoryView: IMInputAccessoryView {

    override func layoutUI() {
        super.layoutUI()
        
        imageButton.snp.remakeConstraints {
            $0.width.equalTo(0.0)
        }
        cameraButton.snp.remakeConstraints {
            $0.width.equalTo(0.0)
        }
        audioButton.snp.remakeConstraints {
            $0.width.equalTo(0.0)
        }
        
        imageButton.clipsToBounds = true
        cameraButton.clipsToBounds = true
        audioButton.clipsToBounds = true
        
        textBarLeftConstraint?.update(offset: 50)
        
        stickerButton.setImage(
            UIImage(named: "chatInBankStickerButtonIcon"),
            for: .normal
        )
        addButton.setImage(
            UIImage(named: "chatInBankPlusButtonIcon"),
            for: .normal
        )
        sendButton.setImage(
            UIImage(named: "chatInBankSendButtonIcon"),
            for: .normal
        )
        returnButton.setImage(
            UIImage(named: "chatInBankPlusButtonIcon"),
            for: .normal
        )
    }

    override func foldTextBar() {
        super.foldTextBar()
        
        // avoid textBar been folded after textViewDidEndEditing
        // imkit_refactor
        textBarLeftConstraint?.update(offset: 50)
    }

    override func addButtonTapped() {
        super.addButtonTapped()
        addButton.setImage(
            UIImage(named: "close"),
            for: .normal
        )
    }
    
    override func resignAllFirstResponder() {
        super.resignAllFirstResponder()
        addButton.setImage(
            UIImage(named: "chatInBankPlusButtonIcon"),
            for: .normal
        )
    }
}
