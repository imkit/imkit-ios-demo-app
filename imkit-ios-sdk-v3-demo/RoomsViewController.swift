//
//  RoomsViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Howard Sun on 2019/10/27.
//  Copyright © 2019 Howard Sun. All rights reserved.
//

import Foundation
import IMKit

class RoomsViewController: IMRoomsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "登出", style: .plain, target: self, action: #selector(logout))
    }
    
    @objc func logout() {
        IMUnsubscribeTask().perform().done { _ in
            IMSocketManager.shared.disconnect()
            IMKit.clear()
            self.dismiss(animated: true, completion: nil)
        }.catch { error in
            print(error)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let element = viewModel.sections[indexPath.section].elements[indexPath.row]
        if let room = element.base as? IMRoom {
            guard let navigationController = navigationController else { return }
            let vc = MessagesViewController(roomID: room.id)
            vc.hidesBottomBarWhenPushed = true
            vc.navigationItem.title = room.name
            navigationController.pushViewController(vc, animated: true)
        } else {
            super.collectionView(collectionView, didSelectItemAt: indexPath)
        }
    }
}
