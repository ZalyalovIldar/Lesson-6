//
//  PostCollectionViewCell.swift
//  Threads
//
//  Created by underq  on 12.12.2019.
//  Copyright © 2019 Ildar Zalyalov. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    func configure(with post: Post) {
        postImageView.image = UIImage(named: post.image)
    }
}
