import UIKit

private let postCellIdentifier = "PostCell"

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PostModel]!
    var postIndexPath: IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Не работает(
        //self.navigationItem.backBarButtonItem?.title = ""
        
        setupTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.scrollToRow(at: postIndexPath, at: .top, animated: false)
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
