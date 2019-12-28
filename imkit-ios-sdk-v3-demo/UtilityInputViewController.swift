//
//  UtilityInputViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Howard Sun on 2019/10/27.
//  Copyright © 2019 Howard Sun. All rights reserved.
//

import Foundation
import IMKit

class UtilityInputViewController: IMUtilityInputViewController {
 
    // UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch IMUtilityType.allCases[indexPath.row] {
        case .Location:
           (viewController as? IMMessagesViewController)?.presentLocationPicker()
        case .File:
           (viewController as? IMMessagesViewController)?.presentDocumentPicker()
        default:
            break
        }
        
        // handle your extra utilities
        // viewController?.present(UIViewController(), animated: true, completion: nil)
    }
    
    // UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // you can add extra data source for additional utilities
        return IMUtilityType.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IMUtilityCollectionViewCell", for: indexPath) as! IMUtilityCollectionViewCell
        cell.type = IMUtilityType.allCases[indexPath.row]
        
        // for your own customized cell
        cell.imageView.image = UIImage(named: "icon_pin_w24_h24", in: IMKit.bundle, compatibleWith: nil)
        cell.label.text = "n.location".IMLocalized
        
        return cell
    }
}
