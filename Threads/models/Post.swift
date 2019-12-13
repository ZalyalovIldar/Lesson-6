//
//  Post.swift
//  Threads
//
//  Created by underq  on 11.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import Foundation

struct Post {
    
    let id: String!
    let image: String!
    let text: String?
    let date: String
    let likes: Int
    
    init(image: String!, text: String?, date: String!, likes: Int!){
        
        id = UUID().uuidString
        
        self.image = image
        self.text = text
        self.date = date
        self.likes = likes
    }
}
