import UIKit
import Alamofire
import SwiftyJSON

class PostsTableViewController: UITableViewController
{
    var user: JSON!
    var posts: [JSON] = []
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getPosts()
        title = user["name"].string
    }
        
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToComment" {
            guard let commentVC = segue.destination as? CommentsTVC else { return }
            guard let postId = sender as? Int else { return }
            commentVC.getComments(with: "\(URLConstants.urlComments)/\(postId)/comments")
            
        }
        if segue.identifier == "goToAddPost" {
            guard let addPostVC = segue.destination as? AddPostVC else { return }
            guard let user = user else { return }
            addPostVC.user = user
        }
    }
    
    private func getPosts()
    {
        guard let userId = user["id"].int else { return }
        guard let url = URL(string: "\(URLConstants.urlPosts)\(userId)") else { return }

        AF.request(url).responseJSON { [weak self] response in
            switch response.result {
                case .success(let data):
                    self?.posts = JSON(data).arrayValue
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    @IBAction func unwindToAllPosts(_ unwindSegue: UIStoryboardSegue)
    {
        //Рабочий способо добавлять новый пост через модалку (то есть сразу видеть результат)
        viewDidLoad()
    }

    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = posts[indexPath.row]["title"].string?.firstCapitalized
        cell.detailTextLabel?.text = posts[indexPath.row]["body"].string?.firstCapitalized
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        zebraTable(with: cell, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            guard let id = posts[indexPath.row]["id"].int else { return }
            AF.request("\(URLConstants.urlDomain)/posts/\(id)", method: .delete, parameters: nil, headers: nil)
                .validate()
                .responseJSON { response in
                    if case .failure(let error) = response.result {
                        print(error)
                    }
                }
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let postId = posts[indexPath.row]["id"].int
        performSegue(withIdentifier: "goToComment", sender: postId)
    }
}
