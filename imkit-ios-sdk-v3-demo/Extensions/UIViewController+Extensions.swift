//
//  UIViewController+Extensions.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/9/13.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import UIKit

extension UIViewController {
    /// https://stackoverflow.com/a/53502078
    private func addCustomizedBackBtn(navigationController: UINavigationController?, navigationItem: UINavigationItem?) {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        navigationItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    func setupNoBackButtonTitleOnNavibar() {
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
    }
    
    var topbarHeight: CGFloat {
        return safeAreaInsetsTop + (navigationController?.navigationBar.frame.height ?? 0.0)
    }

    var toolbarHeight: CGFloat {
        return safeAreaInsetsBottom + (navigationController?.toolbar.frame.height ?? 0.0)
    }

    var safeAreaInsetsTop: CGFloat {
        return (AppDelegate.shared.window?.safeAreaInsets.top ?? 0.0)
    }

    var safeAreaInsetsBottom: CGFloat {
        return (AppDelegate.shared.window?.safeAreaInsets.bottom ?? 0.0)
    }
}
