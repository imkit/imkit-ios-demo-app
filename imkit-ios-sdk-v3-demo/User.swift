//
//  User.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/24.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation

struct User {
    let uuid: String
    let nickname: String
    var avatarIndex: Int = 0
    
    
}

extension User {
    static var mockUserCoco: User = User(uuid: "coco_id", nickname: "Coco")
    static var mockUserLora: User = User(uuid: "lora_id", nickname: "Lora")
    static var mockUserCharle: User = User(uuid: "charle_id", nickname: "Charle")
}
