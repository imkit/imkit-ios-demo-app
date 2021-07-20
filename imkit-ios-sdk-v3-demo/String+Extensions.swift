//
//  String+Extensions.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/19.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
