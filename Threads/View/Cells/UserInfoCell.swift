//
//  UserInfoCell.swift
//  Threads
//
//  Created by Amir on 24.10.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class UserInfoCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var postsCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followingsCountLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    //MARK: - Property
    var user: User!
    
    //MARK: - Configuring cell
    func configure(with user: User) {
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.image = user.profileImage
        profileImageView.layer.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        profileImageView.layer.borderWidth = 1
        profileImageView.clipsToBounds = true
        
        postsCountLabel.text = String(user.posts.count)
        followersCountLabel.text = String(64)
        followingsCountLabel.text = String(151)
        
        nameLabel.text = user.name
        
        editButton.layer.cornerRadius = 5
        editButton.layer.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        editButton.layer.borderWidth = 1
    }
}
