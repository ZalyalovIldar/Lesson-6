import UIKit

class DetailedPhotoViewController: UIViewController {
    
    var image: UIImage!

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var photo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        photo.image = image
    }
    
    func setupUI() {
        userImage.layer.cornerRadius = userImage.frame.height / 2
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
