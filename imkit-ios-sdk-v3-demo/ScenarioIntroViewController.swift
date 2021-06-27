//
//  ScenarioIntroViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/22.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit
import IMKit
import PromiseKit

class ScenarioIntroViewController: UIViewController {

    var model: ScenarioIntroDto?
    var user: User?
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startButton.layer.cornerRadius = startButton.bounds.height / 2.0
        if let model = model {
            title = model.title
            contentTextView.text = model.content
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? TradingPlatformProductViewController {
            vc.user = user
        }
    }
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        guard let model = model else { return }
        switch model.type {
        case .tradingPlatform:
            performSegue(withIdentifier: "goTradingPlatform", sender: nil)
            break
//        case .chatInBanking:
//            break
//        case .networkingChat:
//            break
//        case .businessChat:
//            break
        
        default:
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
                .done({ _ in
                    let roomList = IMRoomsViewController()
                    self.navigationController?.pushViewController(roomList, animated: true)
                })
                .catch({ error in
                    print(error)
                })
            break
        }
    }
}
