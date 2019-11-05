import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postsAmountLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var images: [UIImage] = LocalDataManager.getImages(complition: nil)
    
    var setImageForCell: ((Int, CollectionViewCell) -> Void)!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupCollectionView()
        
        setImageForCell = { imageIndex, cell in
            cell.image.image = self.images[imageIndex]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let detailedPhotoViewController = segue.destination as? DetailedPhotoViewController else { return }
        let image = sender as? UIImage
        detailedPhotoViewController.image = image
    }
}

//MARK: - Collection View

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        setImageForCell(indexPath.row, cell)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        layout.minimumInteritemSpacing = 03
        layout.minimumLineSpacing = 03
        layout.invalidateLayout()

        return CGSize(width: ((self.view.frame.width/3) - 4), height:((self.view.frame.width / 3) - 4));
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailedImageSegue", sender: images[indexPath.row])
    }
}

//MARK: - Setup Functions

extension ProfileViewController {
    
    func setupUI() {
        
        userImage.layer.cornerRadius = userImage.frame.height / 2
        
        editProfileButton.layer.borderColor = UIColor(white: 0.8, alpha: 1.0).cgColor
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.cornerRadius = editProfileButton.frame.height / 8
    }
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let nibCell = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "cell")
    }
}
