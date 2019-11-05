import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func showMoreButtonPressed(_ sender: UIButton) {
        //TODO: 
    }
    
    func setup(for postModel: PostModel) {
        
        setupUI()
        
        userImage.image = postModel.userImage
        userName.text = postModel.nickName
        photo.image = postModel.photo
        postText.text = postModel.text
        dateLabel.text = postModel.date
    }
    
    func setupUI() {
        userImage.layer.cornerRadius = userImage.frame.height / 2
        selectionStyle = .none
    }
}
