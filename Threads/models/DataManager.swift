//
//  DataManager.swift
//  Threads
//
//  Created by underq  on 11.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class DataManager: DataManagerProtocol {
    
    static let sharedData = DataManager()
    private var user: User
    private var posts: [Post]
    
    init() {
        
        posts = []
        
        for i in 0 ... 8 {
            
            let likes = Int.random(in: 0...1000)
            posts.append(Post(image: "postPic\(i + 1)", text: "just text", date: "\(i) дней назад", likes: likes))
        }
        
        user = User(name: "underq", avatar: "avatarPic1", bio: "suspended in twilight", posts: posts)
    }
    
    func syncSavePost(post: Post) {
        self.posts.append(post)
    }
    
    func asyncSavePost(post: Post, completion: @escaping () -> Void) {
        
        let operationQueue = OperationQueue()
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let operation = BlockOperation { [weak self] in
                
                self?.posts.append(post)
                completion()
            }
            operationQueue.addOperation(operation)
        }
    }
    
    func syncDeletePost(postId: String) {
        
        posts.removeAll { (post) -> Bool in
            post.id == postId
        }
    }
    
    func asyncDeletePost(with post: Post, completion: @escaping ([Post]) -> Void) {
        
        let operationQueue = OperationQueue()
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let operation = BlockOperation { [weak self] in
                
                guard let index = self?.posts.firstIndex(where: {$0.id == post.id}) else { return }
                
                self?.posts.remove(at: index)
                
                DispatchQueue.main.async { [weak self] in
                    
                    guard let posts = self?.posts else { return }
                    completion(posts)
                }
            }
            operationQueue.addOperation(operation)
        }
    }
    
    func syncGetPosts() -> [Post] {
        return self.posts
    }
    
    func asyncGetPosts(completion: @escaping (([Post]) -> Void)) {
        
        let operationQueue = OperationQueue()
               
               DispatchQueue.global(qos: .userInteractive).async {
                   
                   let operation = BlockOperation { [weak self] in
                       
                       guard let posts = self?.posts else { return }
                       
                       completion(posts)
                   }
                   operationQueue.addOperation(operation)
               }
    }
    
    func syncGetUser() -> User {
        return self.user
    }
    
    func asyncGetUser(completion: @escaping (User) -> Void) {
        
        let operationQueue = OperationQueue()
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let operation = BlockOperation { [weak self] in
                
                guard let user = self?.user else { return }
                
                completion(user)
            }
            operationQueue.addOperation(operation)
        }
    }
    
    func syncSearchPost(for searchingName: String) -> [Post] {
        
        let foundPosts = posts.filter { (post) -> Bool in
            
            if let postText = post.text {
                return postText.contains(searchingName)
            }
            return false
        }
        return foundPosts
    }
    
    func asyncSearchPost(for searchingName: String, completion: @escaping (([Post]) -> Void)) {
        
        let operationQueue = OperationQueue()
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let operation = BlockOperation { [weak self] in
                
                let filteredPosts = self?.posts.filter({ post -> Bool in
                    return (post.text?.lowercased().contains(searchingName.lowercased()))!
                })
                
                guard let filteredPostsUnwrapped = filteredPosts
                    else { return }
                completion(filteredPostsUnwrapped)
            }
            operationQueue.addOperation(operation)
        }
    }
}

