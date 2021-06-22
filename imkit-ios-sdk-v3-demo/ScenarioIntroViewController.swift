//
//  ScenarioIntroViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/6/22.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit

class ScenarioIntroViewController: UIViewController {

    var model: ScenarioIntroDto?
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var startButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        startButton.layer.cornerRadius = startButton.bounds.height / 2.0
        if let model = model {
            title = model.title
            contentTextView.text = model.content
        }
        
     
    }
    
    
    
}
