//
//  IMNavigationController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by SHI-BO LIN on 2022/3/28.
//  Copyright © 2022 Howard Sun. All rights reserved.
//

import UIKit

class IMNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let barAppearance = UINavigationBarAppearance()
        // Do any additional setup after loading the view. let barAppearance = UINavigationBarAppearance()
     
        barAppearance.configureWithDefaultBackground()
        barAppearance.backgroundColor = .white

      

        navigationBar.standardAppearance = barAppearance
        navigationBar.scrollEdgeAppearance = barAppearance
        
        navigationBar.tintColor = .black
    }
}
