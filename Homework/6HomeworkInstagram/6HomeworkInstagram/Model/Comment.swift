//
//  Comment.swift
//  6HomeworkInstagram
//
//  Created by Роман Шуркин on 18.11.2019.
//  Copyright © 2019 Роман Шуркин. All rights reserved.
//

import Foundation

struct Comment {
    var id: String
    var text: String
    var post: Post
    var user: User
    var date: Date
}
