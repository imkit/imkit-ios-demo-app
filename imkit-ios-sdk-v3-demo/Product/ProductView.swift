//
//  ProductView.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by SHI-BO LIN on 2022/3/27.
//  Copyright © 2022 Howard Sun. All rights reserved.
//

import UIKit

class ProductView: UIView {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 4
            imageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!


    
    func configure(product: Product) {
        titleLabel.text = product.title
        descLabel.text = product.desc
        priceLabel.text = product.price
        imageView.image = product.image
    }
}
