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
            .done({ room in                
                let room = IMRoomViewController(roomID: room.id)
                self.navigationController?.pushViewController(room, animated: true)
            })
            .catch({ error in
                print(error)
            })
    }
}
