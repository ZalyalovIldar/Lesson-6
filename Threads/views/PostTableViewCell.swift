//
//  PostTableViewCell.swift
//  Threads
//
//  Created by underq  on 12.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var topNameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var bottomNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    
    
    var post: Post!
    weak var cellDelegate: DeletePostDelegate!
    
    //MARK: - Configure cell
    func configure(with user: User) {
        
        avatarImageView.image = UIImage(named: user.avatar)
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.clipsToBounds = true
        
        topNameLabel.text = user.name
        postImageView.image = UIImage(named: post.image)
        
        likesLabel.text = "Liked: \(post.likes)"
        bottomNameLabel.text = user.name
        postTextLabel.text = post.text
        dateLabel.text = post.date
    }
    
    //MARK: - Delete button action
    @IBAction func actionsButtonPressed(_ sender: Any) {
        cellDelegate.deletePost(post: post)
    }
}
