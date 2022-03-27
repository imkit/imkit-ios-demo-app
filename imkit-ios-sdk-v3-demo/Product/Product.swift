//
//  Product.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by SHI-BO LIN on 2022/3/27.
//  Copyright © 2022 Howard Sun. All rights reserved.
//

import Foundation
import UIKit


struct Product{
    static let sample: Product = Product(title: "TradingPlatformProductViewController_mock_product_title".localized, price: "TradingPlatformProductViewController_mock_product_price".localized, desc: "TradingPlatformProductViewController_mock_product_description".localized)
    let title: String
    let price: String
    let desc: String
    let image: UIImage = UIImage(named: "sampleProduct")!
    
}
