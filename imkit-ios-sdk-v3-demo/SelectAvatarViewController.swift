//
//  SelectAvatarViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/22.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit

class SelectAvatarViewController: UIViewController {

    var user: User?
    private var selectedIndex: Int = 0

    @IBOutlet weak var sceneTitleLabel: UILabel!
    @IBOutlet weak var check1: UIImageView!
    @IBOutlet weak var check2: UIImageView!
    @IBOutlet weak var check3: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectAvatar(index: 0) // init
        sceneTitleLabel.text = "SelectAvatarViewController_title".localized
        nextButton.setTitle("SelectAvatarViewController_next_button_title".localized, for: .normal)
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
        showSampleListViewController()
    }
    func showSampleListViewController() {
        performSegue(withIdentifier: "goSampleList", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {        
        if let navi = segue.destination as? UINavigationController,
           let vc = navi.viewControllers.first as? SampleListViewController {
            user?.avatarIndex = selectedIndex
            vc.user = user
        }
    }
}

private extension SelectAvatarViewController {
    func selectAvatar(index: Int) {
        selectedIndex = index
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
