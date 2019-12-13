//
//  PostsViewController.swift
//  Threads
//
//  Created by underq  on 11.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    //MARK: - Constants
    let postTableViewCellId = "tableViewCell"
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Data
    var user: User!
    var posts: [Post]!
    
    var indexPathRow: Int!
    weak var delegate: DeletePostDelegate!
    let searchController = UISearchController(searchResultsController: nil)
    var filteredPosts = [Post]()
    
    //MARK: - Helpers
    var searchBarIsEmpty: Bool {
        
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var isFiltering: Bool { return searchController.isActive && !searchBarIsEmpty }
    
    //MARK: - Configuring
    private func configure() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Search Controller Configuring
    private func configureSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Searching"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        DataManager.sharedData.asyncSearchPost(for: searchController.searchBar.text!) { filteredPosts in
            
            self.filteredPosts = filteredPosts
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Get Data func
    private func getData() {
        
        DataManager.sharedData.asyncGetUser { [weak self] user in
            
            self?.user = user
        }
        
        DataManager.sharedData.asyncGetPosts { [weak self] postsArray in
            
            self?.posts = postsArray
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    //MARK: - TableView DataSource & Delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filteredPosts.count : posts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: postTableViewCellId, for: indexPath) as! PostTableViewCell
        
        var post: Post
        
        post = isFiltering ? filteredPosts[indexPath.row] : posts[indexPath.row]
        
        cell.post = post
        cell.cellDelegate = self
        cell.configure(with: user)
        
        return cell
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        configure()
        configureSearchController()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.scrollToRow(at: IndexPath(row: indexPathRow , section: 0), at: .middle, animated: true)
    }
}

//MARK: - Delete Post Extension
extension PostsViewController: DeletePostDelegate {
    
    func deletePost(post: Post) {
        
        let alertController = UIAlertController(title: "Delete", message: "Delete post?", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] action -> Void in
            
            DataManager.sharedData.asyncDeletePost(with: post) { [weak self] posts in
                
                self?.posts = posts
                
                DispatchQueue.main.async {
                    
                    self?.delegate?.deletePost(post: post)
                    self?.tableView.reloadData()
                }
            }
        }
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
