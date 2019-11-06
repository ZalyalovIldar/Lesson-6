import UIKit

private let postCellIdentifier = "PostCell"

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PostModel]!
    var postIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.scrollToRow(at: postIndexPath, at: .top, animated: true)
    }
    
    func fetchData() {
        
        LocalDataManager.shared.asyncGetPosts { postModels in
            
            DispatchQueue.main.async {
                self.posts = postModels
                self.tableView.reloadData()
            }
        }
    }
}

//MARK: - TableView

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: postCellIdentifier) as! PostCell
        cell.setup(for: posts[indexPath.row])
        cell.postCellDelegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        //TODO: Dynamic cell height
        return 660.0
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let nibCell = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: postCellIdentifier)
    }
}

//MARK: - PostCell Delegate

extension PostsViewController: PostCellDelegate {
    
    func presentActionSheet(actionSheet: UIAlertController) {
        present(actionSheet, animated: true, completion: nil)
    }
    
    func reloadData() {
        fetchData()
    }
}
