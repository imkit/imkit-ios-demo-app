//
//  FirstViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Howard Sun on 2018/9/19.
//  Copyright © 2018年 Howard Sun. All rights reserved.
//

import UIKit

import PromiseKit

class FirstViewController: UIViewController {

    @IBOutlet weak var clientIdTextfield: UITextField!
    @IBOutlet weak var nicknameTextfield: UITextField!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var nicknameWrapper: UIView!
    @IBOutlet weak var clientIdWrapper: UIView!
    
    private var clientIdUserTyped: String? {
        if let content = clientIdTextfield.text {
            return content.trimmed()
        } else {
            return nil
        }
    }
    
    private var isClientIdValid: Bool {
        //kimuranow
        if let clientId = clientIdUserTyped {
            return clientId.count >= 4
        } else {
            return false
        }
    }
    
    private var nicknameUserTyped: String? {
        if let content = nicknameTextfield.text {
            return content.trimmed()
        } else {
            return nil
        }
    }
    
    private var isNicknameValid: Bool {
        //kimuranow
        if let nickname = nicknameUserTyped {
            return nickname.count >= 4
        } else {
            return false
        }
    }

    
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
    
        
    
    @IBAction func signinButtonPressed(_ sender: UIButton) {
        clientIdWrapper.layer.borderColor = UIColor(named: "themeColor")?.cgColor
        nicknameWrapper.layer.borderColor = UIColor(named: "themeColor")?.cgColor
        guard let clientId = clientIdUserTyped, !clientId.isEmpty else {
            //kimuranow: error-handling
            clientIdWrapper.layer.borderColor = UIColor.red.cgColor
            return
        }
        guard isClientIdValid else {
            //kimuranow: error-handling
            clientIdWrapper.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        guard let nickname = nicknameUserTyped, !nickname.isEmpty else {
            //kimuranow: error-handling
            nicknameWrapper.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        guard isNicknameValid else {
            //kimuranow: error-handling
            nicknameWrapper.layer.borderColor = UIColor.red.cgColor
            return
        }
        showSelectAvatarViewController()
    }
    
    func showSelectAvatarViewController() {
        performSegue(withIdentifier: "goSelectAvatar", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SelectAvatarViewController,
           let clientIdUserTyped = clientIdUserTyped,
           let nicknameUserTyped = nicknameUserTyped {
            vc.user = User(
                uuid: clientIdUserTyped,
                nickname: nicknameUserTyped
            )
        }
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

extension String {
    func trimmed() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
