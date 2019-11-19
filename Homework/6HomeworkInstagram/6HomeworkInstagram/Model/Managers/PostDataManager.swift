//
//  DataManager.swift
//  6HomeworkInstagram
//
//  Created by Роман Шуркин on 16/11/2019.
//  Copyright © 2019 Роман Шуркин. All rights reserved.
//

import Foundation
import UIKit

protocol DataProtocol {
    func syncSave(post: Post)
    func asyncSave(post: Post, completion: @escaping () -> Void)
    func syncGet(id: String) -> Post?
    func asyncGet(id: String, completion: @escaping (Post) -> Void)
    func syncGetAllOfUser(user: User) -> [Post]
    func asyncGetAllOfUser(user: User, completion: @escaping ([Post]) -> Void)
    func syncGetAll() -> [Post]
    func asyncGetAll(completion: @escaping ([Post]) -> Void)
    func syncRemove(id: String)
    func asyncRemove(id: String, completion: @escaping ([Post]) -> Void)
    func syncSearch(id: String)
    func asyncSearch(textOfSearch: String, completion: @escaping ([Post]) -> Void)
}

/// Data Manager of User
class PostDataManager: DataProtocol {

    static var shared = PostDataManager()
    
    var allPosts: [Post]

    private init() {
        
        let user: User = UserDataManager().getUser(nickname: "romash_only")
        
        allPosts = [
            Post(id: "0", image: UIImage(named: "post1")!, text: "Hello", user: user, likes: 2, date: Date()),
            Post(id: "1", image: UIImage(named: "post2")!, text: "Hai", user: user, likes: 2, date: Date()),
            Post(id: "2", image: UIImage(named: "post3")!, text: "Good", user: user, likes: 2, date: Date()),
            Post(id: "3", image: UIImage(named: "post4")!, text: "Very Bad", user: user, likes: 2, date: Date()),
        ]
    }
    
    func syncSave(post: Post) {
        allPosts.append(post)
    }
    
    func asyncSave(post: Post, completion: @escaping () -> Void) {
        
        let operationQueue = OperationQueue()

        DispatchQueue.global(qos: .userInteractive).async {

            let operation = BlockOperation { [weak self] in

                self?.allPosts.append(post)

                DispatchQueue.main.async { completion() }
            }

            operationQueue.addOperation(operation)
        }
    }
    
    func syncGet(id: String) -> Post? {
        return allPosts.filter {
            $0.id == id
        }.first
    }
    
    func asyncGet(id: String, completion: @escaping (Post) -> Void) {
        return
    }
    
    func syncGetAllOfUser(user: User) -> [Post] {
        return reverse(array: allPosts.filter { $0.user.id == user.id })
    }
    
    func asyncGetAllOfUser(user: User, completion: @escaping ([Post]) -> Void) {
        
        let operationQueue = OperationQueue()

        DispatchQueue.global(qos: .userInteractive).async {

            let operation = BlockOperation { [weak self] in


                DispatchQueue.main.async { [weak self] in

                    if let posts = self?.reverse(array: (self?.allPosts.filter { $0.user.id == user.id })!) {
                        completion(posts)
                    }
                }
            }

            operationQueue.addOperation(operation)
        }
    }
    
    func syncGetAll() -> [Post] {
        return allPosts
    }
    
    func asyncGetAll(completion: @escaping ([Post]) -> Void) {
        
        let operationQueue = OperationQueue()

        DispatchQueue.global(qos: .userInteractive).async {

            let operation = BlockOperation { [weak self] in


                DispatchQueue.main.async { [weak self] in

                    if let posts = self?.allPosts {
                        completion(posts)
                    }
                }
            }

            operationQueue.addOperation(operation)
        }
    }
    
    func syncRemove(id: String) {
        return allPosts.removeAll {
            $0.id == id
        }
    }
    
    func asyncRemove(id: String, completion: @escaping ([Post]) -> Void) {
        
        let operationQueue = OperationQueue()

        DispatchQueue.global(qos: .userInteractive).async {

            let operation = BlockOperation { [weak self] in

                self?.allPosts.removeAll {
                    $0.id == id
                }

                DispatchQueue.main.async { [weak self] in

                    if let posts = self?.allPosts {
                        completion(posts)
                    }
                }
            }

            operationQueue.addOperation(operation)
        }
    }
    
    func syncSearch(id: String) {
        return
    }
    
    func asyncSearch(textOfSearch: String, completion: @escaping ([Post]) -> Void) {
        
        let operationQueue = OperationQueue()
        
        DispatchQueue.global(qos: .userInteractive).async {
            let operation = BlockOperation { [weak self] in
                
                if let filterPosts = self?.allPosts.filter({ $0.text.lowercased().contains(textOfSearch.lowercased()) }) {
                    DispatchQueue.main.async {
                        completion(filterPosts)
                    }
                }
            }
            operationQueue.addOperation(operation)
        }
    }
    
    func getUIImage(name: String) -> UIImage {
     return UIImage(named: name) ?? UIImage()
    }
    
    func reverse(array: [Post]) -> [Post] {
        
        var reverseArray = array
        
        for index in 0...reverseArray.count {
            if index < reverseArray.count / 2 {
                let t = reverseArray[index]
                reverseArray[index] = reverseArray[reverseArray.count - index - 1]
                reverseArray[reverseArray.count - index - 1] = t
            }
            else {
                break
            }
        }
        return reverseArray
    }

}
