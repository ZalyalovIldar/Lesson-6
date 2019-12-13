//
//  DeletePostDelegate.swift
//  Threads
//
//  Created by underq  on 11.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

protocol DeletePostDelegate: AnyObject {
    
    func deletePost(post: Post)
}
