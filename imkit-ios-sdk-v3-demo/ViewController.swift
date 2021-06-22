//
//  ViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Howard Sun on 2018/9/19.
//  Copyright © 2018年 Howard Sun. All rights reserved.
//

import UIKit
import IMKit
import PromiseKit

class ViewController: UIViewController {

    @IBOutlet weak var clientIdTextfield: UITextField!
    @IBOutlet weak var nicknameTextfield: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var nicknameWrapper: UIView!
    @IBOutlet weak var clientIdWrapper: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        signinButton.layer.cornerRadius = signinButton.bounds.height / 2.0
        
        clientIdWrapper.layer.cornerRadius = 28.0
        clientIdWrapper.layer.borderWidth = 1.0
        clientIdWrapper.layer.borderColor = UIColor(named: "themeColor")?.cgColor
        nicknameWrapper.layer.cornerRadius = 28.0
        nicknameWrapper.layer.borderWidth = 1.0
        nicknameWrapper.layer.borderColor = UIColor(named: "themeColor")?.cgColor                
    }
    
    
    
/*
    @IBAction func go(_ sender: Any) {
        let uid = nameTextField.text ?? ""
        let chatroom = chatroomTextField.text ?? ""
        print(uid)
        print(chatroom)
        IMKit.clear()
        IMFetchTokenTask().perform(uid: uid).then { token -> Promise<IMRoom> in
            IMKit.token = token
            IMKit.uid = uid
            return IMCreateRoomTask().perform(id: chatroom, name: chatroom)
            }.then({ room -> Promise<IMRoom> in
                return IMJoinRoomTask().perform(id: room.id)
            }).done({ _ in
                
                // default IMKit rooms view controller
                let vc = UINavigationController(rootViewController: IMRoomsViewController())
                vc.modalPresentationStyle = .overFullScreen
                // customized rooms view controller
                // let vc = UINavigationController(rootViewController: RoomsViewController())
                self.present(vc, animated: true)
            }).catch { error in
                print(error)
        }
    }
 */
    
}

