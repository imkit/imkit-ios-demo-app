//
//  IMKitManager.swift
//  ShareExtension
//
//  Created by SHI-BO LIN on 2022/3/29.
//

import Foundation
import IMKit
class IMKitManager {
    static let shared = IMKitManager()
    func fetchRooms(completionHandler: @escaping (Swift.Result<[IMRoom], NSError>) -> Void) {
        IMFetchRoomsTask().perform(numberOfRoomsPerRequest: 1000, page: 1).done { rooms in
            completionHandler(.success(rooms))
        }.catch { error in
            completionHandler(.failure(error as NSError))
        }
    }
}
