//
//  TradingPlatformProductViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/23.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit
import IMKit
import PromiseKit

class TradingPlatformProductViewController: UIViewController {
    
    var user: User?

    @IBAction func chatButtonPressed(_ sender: UIButton) {
        guard let user = user else { return }
        IMKit.clear()
        
        IMFetchTokenTask().perform(uid: user.uuid)
            .then({ token -> Promise<IMRoom> in
                IMKit.token = token
                IMKit.uid = user.uuid
                return IMCreateRoomTask().perform(
                    id: "room",   //kimuranow
                    name: "room"  //kimuranow
                )
            })
            .then({ room -> Promise<IMRoom> in
                return IMJoinRoomTask().perform(id: room.id)
            })
            .then({ room -> Promise<IMRoom> in
                return IMUpdateRoomTask().perform(
                    id: room.id,
                    
                    coverURL: URL(string: "https://upload.wikimedia.org/wikipedia/en/3/34/Fallout_New_Vegas.jpg"),
                    description: "HELLO, WORLD"
                    
                )
            })
            .done({ room in
                let room = IMChatRoomViewController(roomID: room.id)
                // imkit-customized: 1. custom navigation bar color
                self.navigationController?.navigationBar.barTintColor = DemoScenarioType.tradingPlatform.subColor
                
                // imkit-customized: 整個聊天室背景
//                IMStyle.messages.backgroundColor = .red
                IMStyle.messages.textCell.response.backgroundColor = .red
                
                
                
                self.navigationController?.pushViewController(room, animated: true)
            })
            .catch({ error in
                print(error)
            })
    }
}
