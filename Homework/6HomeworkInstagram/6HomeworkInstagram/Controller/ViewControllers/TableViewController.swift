//
//  TableViewController.swift
//  6HomeworkInstagram
//
//  Created by Роман Шуркин on 18.11.2019.
//  Copyright © 2019 Роман Шуркин. All rights reserved.
//

import UIKit

protocol TableViewControllerDelegate: AnyObject {
    func didChangeInfo(_ post: Post)
}

private let postIden = TableViewCell.cellIden()

class TableViewController: UITableViewController, UISearchBarDelegate, TableViewControllerDelegate {
    
    let postDM = PostDataManager.shared

    let searchController = UISearchController (searchResultsController: nil )
    
    var postsOfUser: [Post]!
    
    var filterPosts: [Post] = []
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    var cursorIndex: IndexPath!
    
    var getPostFromArray: ((Int) -> Post)!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarPrepare()

        getPostFromArray = { [weak self] index in
            self!.postsOfUser[index]
        }
        
        self.tableView.registerCell(TableViewCell.self)
        
        // Uncomment the following line to preserve selection between presentations
//         self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        //плохо работает, не понимаю почему совсем
        tableView.scrollToRow(at: cursorIndex, at: .top, animated: false)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering {
            return filterPosts.count
        }
        return postsOfUser.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: postIden, for: indexPath) as! TableViewCell

        if isFiltering {
            cell.configure(with: filterPosts[indexPath.item])
        }
        else {
            cell.configure(with: getPostFromArray(indexPath.item))
        }
        
        cell.delegate = self

        return cell
   
    }
    
    func didChangeInfo(_ post: Post) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deletePost = UIAlertAction(title: "Удалить", style: .destructive) { (action) in
        
            let alertDelete = UIAlertController(title: "Удалить пост?", message: nil, preferredStyle: .actionSheet)
            let delete = UIAlertAction(title: "Удалить", style: .destructive) { (action) in
                self.postDM.asyncRemove(id: post.id) { (allPosts) in
                    DispatchQueue.main.async {

                        self.postsOfUser = self.postDM.syncGetAllOfUser(user: post.user)
                        self.tableView.reloadData()
                    }
                }
            }
            let cancelDelete = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            
            alertDelete.addAction(delete)
            alertDelete.addAction(cancelDelete)
            
            self.present(alertDelete, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(deletePost)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    
    func searchBarPrepare() {
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Поиск конфет"
        // 4
        navigationItem.searchController = searchController // 5
        searchController.definesPresentationContext = true

    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        postDM.asyncSearch(textOfSearch: searchText) { (filterPosts) in
            self.filterPosts = filterPosts
            self.tableView.reloadData()
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
