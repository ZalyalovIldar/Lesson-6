//
//  ViewController.swift
//  DynamicTable
//
//  Created by Ильдар Залялов on 09/10/2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        
        DataManager.obtainDataOperation { [weak self] (stringsArray) in
            
            self?.dataSource = stringsArray
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as! CustomTableViewCell
        
        
        cell.configure(with: dataSource[indexPath.row])
        
        return cell 
    }
}

