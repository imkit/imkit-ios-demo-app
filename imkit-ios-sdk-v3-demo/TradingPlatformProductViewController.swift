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
        
        IMFetchTokenTask().perform(uid: "sean135")
            .then({ token -> Promise<IMRoom> in
                IMKit.token = token
                IMKit.uid = "sean135"
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
                IMStyle.messages.backgroundColor = .white
                IMStyle.messages.textCell.response.backgroundColor = .red
                
                IMStyle.navigationBar.tintColor = .black
                
                // imkit-customized: 對方的訊息泡泡
                IMStyle.messages.incomingCell.backgroundColor = DemoScenarioType.tradingPlatform.subColor
                // imkit-customized: 自己的訊息泡泡
                IMStyle.messages.outgoingCell.backgroundColor = UIColor(named: "tradingPlatformGrayColor")!
                
                room.inputBarView.sendButton.setImage(UIImage(named: "tradingPlatformSend"), for: .normal)
                room.inputBarView.imageButton.setImage(UIImage(named: "tradingPlatformImage"), for: .normal)
                room.inputBarView.cameraButton.setImage(UIImage(named: "tradingPlatformCamera"), for: .normal)
                
                
                
                self.navigationController?.pushViewController(room, animated: true)
            })
            .catch({ error in
                print(error)
            })
    }
    
}
