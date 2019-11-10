//
//  Post.swift
//  Threads
//
//  Created by Amir on 13.11.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

struct Post {
    
    let image: UIImage
    let description: String?
    let postId: String
    let time: String
    let likes: Int
    
    init(image: UIImage!, description: String?, time: String!, likes: Int!) {
        
        self.image = image
        self.description = description
        self.time = time
        self.likes = likes
        
        postId = UUID().uuidString
    }
}
