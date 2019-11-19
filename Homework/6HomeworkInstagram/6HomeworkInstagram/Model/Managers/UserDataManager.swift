//
//  UserDataManager.swift
//  6HomeworkInstagram
//
//  Created by Роман Шуркин on 18.11.2019.
//  Copyright © 2019 Роман Шуркин. All rights reserved.
//

import Foundation
import UIKit

///Data Manager of User
class UserDataManager {
    
    static let users: [User] = [User(id: UUID().uuidString, nickname: "romash_only", avatarImage: UIImage(named: "ava"))]
    
    /// Method for getting User
    /// - Parameter nickname: nickname of User
    func getUser(nickname: String) -> User {
        return UserDataManager.users.filter {
            $0.nickname == nickname
        }.first!
    }
}
