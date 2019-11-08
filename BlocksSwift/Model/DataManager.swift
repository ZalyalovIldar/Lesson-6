//
//  DataManager.swift
//  BlocksSwift
//
//  Created by Евгений on 25.10.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import Foundation

class DataManager: DataManagerProtocol {
    
    //Singleton of Data Manager
    public static let dataManagerSingleton = DataManager()
    
    //Constan array of posts
    var posts = [Post(image: "picture1", text: "Hello. Yoda my name is. Yrsssss.", date: "1 ноября 2019"), Post(image: "picture2", text: "Just do it!", date: "25 января 1964"), Post(image: "picture3", text: "Национальное управление по аэронавтике и исследованию космического пространства — ведомство, относящееся к федеральному правительству США и подчиняющееся непосредственно Президенту США.", date: "25 июля 1958"), Post(image: "picture4", text: "Курлык", date: "1 января 2020"), Post(image: "picture5", text: "YOU are the world-famous Mario!?!", date: "13 сентября 1985")]
    
    // MARK: - Saving methods
    
    /// Saves a post synchronously
    /// - Parameter post: Post, which need to save
    func syncSave(_ post: Post) -> [Post] {
        
        posts.append(post)
        return posts
    }
    
    
    /// Saves a post not synchronously
    /// - Parameter post: Post, which need to save
    /// - Parameter completion: Completion block
    func asyncSave(_ post: Post, completion: @escaping ([Post]) -> Void) {
        
        let operationQueue = OperationQueue()
        
        DispatchQueue.global().async {
            
            let appendingOperation = BlockOperation { [weak self] in
                self?.posts.append(post)
            }
            
            DispatchQueue.main.async { [weak self] in
                
                if let posts = self?.posts {
                    completion(posts)
                }
            }
            
            operationQueue.addOperation(appendingOperation)
        }
    }
    
    // MARK: - Getting methods
    
    
    /// Synchronously get posts array
    func syncGet() -> [Post] {
        return posts
    }
    
    
    /// Not synchronously get posts array
    /// - Parameter completion: Completion block
    func asyncGet(completion: @escaping ([Post]) -> Void) {
        
        let operationQueue = OperationQueue()
        
        DispatchQueue.global().async {
            
            let gettingOperation = BlockOperation { [weak self] in
                
                if let posts = self?.posts {
                    
                    completion(posts)
                }
            }
            
            operationQueue.addOperation(gettingOperation)
        }
    }
    
    // MARK: - Deleting methods
    
    
    /// Synchronously delete post
    /// - Parameter post: Post, which need to delete
    func syncDelete(_ post: Post) -> [Post] {
        
        posts.removeAll(where: {$0.id == post.id})
        return posts
    }
    
    
    /// Not synchronously delete post
    /// - Parameter post: Post, which need to delete
    /// - Parameter completion: Completion block
    func asyncDelete(_ post: Post, completion: @escaping ([Post]) -> Void) {
        
        let operationQueue = OperationQueue()
        
        DispatchQueue.global().async {
            
            let deletingOperation = BlockOperation { [weak self] in
                
                if (self?.posts) != nil {
                    self?.posts.removeAll(where: { $0.id == post.id } )
                }
                
                DispatchQueue.main.async {
                    
                    if let posts = self?.posts {
                        completion(posts)
                    }
                }
            }
    
            operationQueue.addOperation(deletingOperation)
        }
    }
    
    // MARK: - Searching methods
    
    
    /// Synchronously search the post in posts array
    /// - Parameter searchQuery: Text, which need to search in post
    func syncSearch(_ searchQuery: String) -> [Post] {
        
        let foundPosts = self.posts.filter( { $0.text.contains(searchQuery) } )
        return foundPosts
    }
    
    
    /// Not synchronously search the post in posts array
    /// - Parameter searchQuery: Text, which need to search in post
    /// - Parameter completion: Completion block
    func asyncSearch(_ searchQuery: String, completion: @escaping ([Post]) -> Void) {
        
        let operationQueue = OperationQueue()
        
        DispatchQueue.global().async {
            
            let searchingOperation = BlockOperation { [weak self] in
                
                let foundPosts = self?.posts.filter( { $0.text.contains(searchQuery) } )
                
                DispatchQueue.main.async {
                    completion(foundPosts ?? [])
                }
            }
            
            operationQueue.addOperation(searchingOperation)
        }
    }
}
