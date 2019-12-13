//
//  ViewController.swift
//  DynamicTable
//
//  Created by Ильдар Залялов on 09/10/2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    //MARK: - Constants
    let showFullPostSegueId = "showPost"
    let postCell = "collectionViewCell"
    
    //MARK: - Data
    var user: User!
    var posts: [Post]!
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var postsCounterLabel: UILabel!
    @IBOutlet weak var followersCounterLabel: UILabel!
    @IBOutlet weak var followingCounterLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    //MARK: - Configuring
    private func configure() {
        
        DataManager.sharedData.asyncGetUser { [weak self] user in
            self?.user = user
            
            DispatchQueue.main.async { [weak self] in
                self?.title = user.name
            }
        }
        
        DataManager.sharedData.asyncGetPosts { [weak self] posts in
            
            self?.posts = posts
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        collectionView.delegate = self
          collectionView.dataSource = self
          
          avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
          avatarImageView.image = UIImage(named: user.avatar)
          avatarImageView.layer.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
          avatarImageView.layer.borderWidth = 1
          avatarImageView.clipsToBounds = true
          
          nameLabel.text = user.name
          postsCounterLabel.text = String(posts.count)
          editButton.layer.cornerRadius = 5
          editButton.layer.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
          editButton.layer.borderWidth = 1
    }
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configure()
    }
    
    //MARK: - CollectionView DataSource & Delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: postCell, for: indexPath) as! PostCollectionViewCell
        
        let post = posts[indexPath.item]
        cell.configure(with: post)
        return cell
    }
    
    //MARK: - Navigation
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: showFullPostSegueId, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == showFullPostSegueId,  let indexPath = sender as? IndexPath {
            
            let dest = segue.destination as! PostsViewController
            
            dest.delegate = self
            dest.indexPathRow = indexPath.row
        }
    }
    
    //MARK: - CollectionView layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.bounds.width - 4) / 3
        return CGSize(width: width, height: width);
    }
    
}

//MARK: - Delete Post Extension
extension ViewController: DeletePostDelegate {
    
    func deletePost(post: Post) {
        
        DataManager.sharedData.asyncGetPosts { [weak self] posts in
            
            self?.posts = posts
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

