//
//  DataManager.swift
//  DynamicTable
//
//  Created by Ильдар Залялов on 30.10.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import Foundation

class DataManager {
    
    class func obtainData(completion: @escaping (([String]) -> Void)) {
        
        var data = [String]()
        
        let group = DispatchGroup()
        
        group.enter()
        
        DispatchQueue.global(qos: .utility).async {
            data.append("all")
            
            group.leave()
        }
        
        group.enter()
        
        DispatchQueue.global().async {
            data.append("hello")
            group.leave()
        }
        
        group.enter()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            data.append("there")
            data.append("!!!")
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion(data)
        }
    }
    
    class func obtainDataOperation(completion: @escaping (([String]) -> Void)) {
        
        var data = [String]()
        
        let operationQueue = OperationQueue()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            
            let operationBlock = BlockOperation {
                for i in 0 ..< 5 {
                    data.append("\(i)🤨")
                }
            }
            
            let operationBlock2 = BlockOperation {
                for i in 0 ..< 5 {
                    data.append("\(i)😇")
                }
            }
            
            let operationBlock3 = BlockOperation {
                data.append("Hello!")
            }
            
            operationBlock3.addDependency(operationBlock)
            operationBlock3.addDependency(operationBlock2)
            
            operationQueue.addOperations([operationBlock, operationBlock2, operationBlock3], waitUntilFinished: true)
            
            completion(data)
        }
    }
}
