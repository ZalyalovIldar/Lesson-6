//
//  Manager.swift
//  Threads
//
//  Created by Amir on 08.11.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class Manager: DataManager {
    
    static let shared = Manager()
    
    private var posts: [Post]
    private var user: User
    
    //MARK: - Save
    
    init() {
        
        posts = []
        
        for index in 1 ... 10 {
            let likes = Int.random(in: 10...100)
            
            posts.append(Post(image: UIImage(named: "postPhoto\(index + 1)"), description: "Описание №\(index)", time: "\(index) часов назад", likes: likes))
        }
        
        user = User(nickName: "omeeer78", name: "Amir", profileImage: UIImage(named: "profileImage1"), posts: posts)
    }
    
    func syncSavePost(post: Post) {
        self.posts.append(post)
    }
    
    func asyncSavePost(post: Post, completion: @escaping () -> Void) {
        
        let queue = DispatchQueue.global()
        queue.async {
            self.posts.append(post)
            completion()
        }
    }
    
    //MARK: - Search
    
    func syncSearchPost(for searchString: String) -> [Post] {
        
        let searchedPosts = posts.filter { (post) -> Bool in
            
            if let postText = post.description {
                return postText.contains(searchString)
            }
            return false
        }
        return searchedPosts
    }
    
    func asyncSearchPost(for searchString: String, completion: @escaping (([Post]) -> Void)) {
        
        let queue = DispatchQueue.global()
        queue.async {
            
            let filteredPosts = self.posts.filter({ post -> Bool in
                return (post.description?.lowercased().contains(searchString.lowercased()))!
            })
            completion(filteredPosts)
        }
    }
    
    //MARK: - Delete
 
    func syncDeletePost(with postID: String) {
        
        posts.removeAll { (post) -> Bool in
            post.postId == postID
        }
    }
    
    func asyncDeletePost(with post: Post, completion: @escaping ([Post]) -> Void) {
        
       let operationQueue = OperationQueue()
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let operation = BlockOperation { [weak self] in
                
                guard let index = self?.posts.firstIndex(where: {$0.postId == post.postId}) else { return }
                self?.posts.remove(at: index)
                
                DispatchQueue.main.async { [weak self] in
                    
                    guard let posts = self?.posts else { return }
                    completion(posts)
                }
            }
            operationQueue.addOperation(operation)
        }
    }
    
    //MARK: - Get
    
    func syncGetPosts() -> [Post] {
        return self.posts
    }
    
    func asyncGetPosts(completion: @escaping (([Post]) -> Void)) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            completion(self.posts)
        }
    }
    
    func asyncGetUser(completion: (User) -> Void) {
        completion(user)
    }
}
