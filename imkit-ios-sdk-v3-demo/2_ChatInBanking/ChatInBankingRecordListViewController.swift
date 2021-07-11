//
//  ChatInBankingRecordListViewController.swift
//  imkit-ios-sdk-v3-demo
//
//  Created by Sean on 2021/7/10.
//  Copyright © 2021 Howard Sun. All rights reserved.
//

import Foundation
import UIKit

class ChatInBankingRecordListViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        return tv
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init() {
        super.init(nibName: nil, bundle: nil)
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ChatInBankingRecordListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.textLabel?.text = "07/04 17:00"
        cell.detailTextLabel?.text = "+ $199"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "2021"
        } else {
            return "2020"
        }
    }
}
