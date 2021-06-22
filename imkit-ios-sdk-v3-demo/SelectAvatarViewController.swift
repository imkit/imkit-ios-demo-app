//
//  SelectAvatarViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/22.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit

class SelectAvatarViewController: UIViewController {


    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var check2: UIImageView!
    @IBOutlet weak var check3: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectAvatar(index: 0) // init
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextButton.layer.cornerRadius = nextButton.bounds.height / 2.0
    }
    
    @IBAction func avatar1ButtonPressed(_ sender: UIButton) {
        selectAvatar(index: 0)
    }
    @IBAction func avatar2ButtonPressed(_ sender: UIButton) {
        selectAvatar(index: 1)
    }
    @IBAction func avatar3ButtonPressed(_ sender: UIButton) {
        selectAvatar(index: 2)
    }
    @IBAction func nextButtonPressed(_ sender: UIButton) {
    }
}

private extension SelectAvatarViewController {
    func selectAvatar(index: Int) {
        check1.isHidden = true
        check2.isHidden = true
        check3.isHidden = true
        
        switch index {
        case 0:
            check1.isHidden = false
            break
        case 1:
            check2.isHidden = false
            break
        case 2:
            check3.isHidden = false
            break
        default:
            check1.isHidden = true
            check2.isHidden = true
            check3.isHidden = true
            break
        }
    }
}
