//
//  Post.swift
//  Threads
//
//  Created by Enoxus on 03/11/2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import Foundation

/// simple post model that contains owner, picture, text and generated id
struct Post {
    
    let owner: User
    let pic: String
    let text: String
    let id = UUID().uuidString
}
