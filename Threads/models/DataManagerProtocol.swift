//
//  ManagerProtocol.swift
//  Threads
//
//  Created by underq  on 11.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

protocol DataManagerProtocol {
    
    func syncSavePost(post: Post)
    func asyncSavePost(post: Post, completion: @escaping () -> Void)
    func syncDeletePost(postId: String)
    func asyncDeletePost(with post: Post, completion: @escaping ([Post]) -> Void)
    func syncGetPosts() -> [Post]
    func asyncGetPosts(completion: @escaping (([Post]) -> Void))
    func syncGetUser() -> User
    func asyncGetUser(completion: @escaping (User) -> Void)
    func syncSearchPost(for searchingName: String) -> [Post]
    func asyncSearchPost(for searchingName: String, completion: @escaping (([Post]) -> Void))
}

