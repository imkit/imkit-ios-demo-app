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

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var chatroomTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // IMKit.configure(clientKey: "", chatServerURL: URL(string: "")!, authServerURL: URL(string: "")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

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
                
                // customized rooms view controller
                // let vc = UINavigationController(rootViewController: RoomsViewController())
                self.present(vc, animated: true)
            }).catch { error in
                print(error)
        }
    }
    
}

