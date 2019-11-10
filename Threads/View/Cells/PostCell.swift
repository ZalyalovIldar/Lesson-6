//
//  PostCell.swift
//  Threads
//
//  Created by Amir on 03.11.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var post: Post!
    weak var cellDelegate: CellDelegate!
    
    func configure(with user: User) {
        
        profileImageView.image = user.profileImage
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
        
        nicknameLabel.text = user.nickName
        nicknameLabel.sizeToFit()
        
        postImageView.image = post.image
        
        likesLabel.text = "Нравится: \(post.likes)"
        
        userNameLabel.text = user.nickName
        postDescriptionLabel.text = post.description
        timeLabel.text = post.time
    }
    
    @IBAction func actionsButtonPressed(_ sender: Any) {
        cellDelegate.delete(post: post)
    }
}
