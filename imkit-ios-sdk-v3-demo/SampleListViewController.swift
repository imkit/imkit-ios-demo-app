//
//  SampleListViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/22.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit

class SampleListViewController: UIViewController {

    @IBOutlet weak var signoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        signoutButton.layer.cornerRadius = 28.0
        signoutButton.layer.borderWidth = 1.0
        signoutButton.layer.borderColor = UIColor(named: "themeColor")?.cgColor       
    }
    
    @IBAction func sampleButton1Pressed(_ sender: UIButton) {
    }
    @IBAction func sampleButton2Pressed(_ sender: UIButton) {
    }
    @IBAction func sampleButton3Pressed(_ sender: UIButton) {
    }
    @IBAction func sampleButton4Pressed(_ sender: UIButton) {
    }
    @IBAction func signOutButtonPressed(_ sender: UIButton) {
    }
}
