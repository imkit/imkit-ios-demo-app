//
//  ChatInBankingUtilityInputViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/7.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import IMKit

@objc public class ChatInBankingUtilityInputViewController: IMUtilityInputViewController {
    
    var transferButtonAction: (() -> Void)?
    var paymentRequestButtonAction: (() -> Void)?
    
    enum UtilityItem {
        case transfer
        case paymentRequest
        var title: String {
            switch self {
            case .transfer: return "轉帳"
            case .paymentRequest: return "收款"
            }
        }
        var image: UIImage? {
            switch self {
            case .transfer: return UIImage(named: "chatInBankingTransferIcon")
            case .paymentRequest: return UIImage(named: "chatInBankingRequestIcon")
            }
        }
    }
    
    let utilityItems: [UtilityItem] = [
        .transfer, .paymentRequest
    ]
            
    override public func viewDidLayoutSubviews() {
        view.frame.size.height = 85 + view.safeAreaInsets.bottom
    }
}
extension ChatInBankingUtilityInputViewController {
    override public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = utilityItems[indexPath.row]
            switch item {
            case .transfer:
                transferButtonPressed()
                break
            case .paymentRequest:
                paymentRequestButtonPressed()
                break
        }
    }
    override public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        utilityItems.count
    }
    
    override public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IMUtilityCollectionViewCell", for: indexPath) as! IMUtilityCollectionViewCell
        cell.imageView.snp.remakeConstraints { make in
            make.width.height.equalTo(40)
            make.centerX.equalTo(cell.contentView)
            make.centerY.equalTo(cell.contentView).offset(-15)
        }
        cell.label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        cell.label.textColor = UIColor(red: 71 / 255, green: 71 / 255, blue: 71 / 255, alpha: 1)
        
        let item = utilityItems[indexPath.row]
        cell.imageView.image = item.image
        cell.label.text = item.title
        return cell
    }
    
    override public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = view.frame.width / 4
        return CGSize(width: size, height: 85)
    }
}
extension ChatInBankingUtilityInputViewController {
    func transferButtonPressed() {
        //kimuranow
        if let action = transferButtonAction {
            action()
        }
    }
    func paymentRequestButtonPressed() {
        //kimuranow
        if let action = paymentRequestButtonAction {
            action()
        }
    }
}
