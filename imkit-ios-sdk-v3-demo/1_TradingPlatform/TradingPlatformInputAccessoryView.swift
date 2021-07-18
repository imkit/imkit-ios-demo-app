//
//  TradingPlatformInputAccessoryView.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/18.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import IMKit
import SnapKit

class TradingPlatformInputAccessoryView: IMInputAccessoryView {
    
    override func layoutUI() {
        super.layoutUI()
        
        textBarLeftConstraint?.update(offset: 90.0)
        
        sendButton.setImage(UIImage(named: "tradingPlatformSend"), for: .normal)
        imageButton.setImage(UIImage(named: "tradingPlatformImage"), for: .normal)
        cameraButton.setImage(UIImage(named: "tradingPlatformCamera"), for: .normal)
//        returnButton
        audioButton.isHidden = true
        sendButton.isHidden = false
        stickerButton.isHidden = true
        
        // imkit-customized: 輸入框左邊少了 add button，要將其空間做平分。
        //        inputBarView.addButton.isHidden = true
        addButton.snp.updateConstraints {
            $0.width.equalTo(0.0)
        }
        cameraButton.snp.updateConstraints {
            $0.left.equalTo(primaryView).offset(5.0)
        }
        imageButton.snp.updateConstraints {
            $0.left.equalTo(primaryView).offset(45.0)
        }
    }
    
    override func foldTextBar() {
        super.foldTextBar()
        // keyboard off
        // avoid textBar been folded after textViewDidEndEditing
        // imkit_refactor
        textBarLeftConstraint?.update(offset: 90.0)
        cameraButton.isHidden = false
        imageButton.isHidden = false
        audioButton.isHidden = true
        sendButton.isHidden = false
    }
    override func expandTextBar() {
        super.expandTextBar()
        // keyboard on
        textBarLeftConstraint?.update(offset: 50.0)
        cameraButton.isHidden = true
        imageButton.isHidden = true
        audioButton.isHidden = true
        sendButton.isHidden = false
    }
}
