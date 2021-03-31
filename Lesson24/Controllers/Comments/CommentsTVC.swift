import UIKit
import Alamofire
import SwiftyJSON

class CommentsTVC: UITableViewController
{
    var comments: [JSON] = []
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToAddComment" {
            guard let updateCommentVC = segue.destination as? UpdateCommentVC else { return }
            guard let postId = sender as? Int else { return }
            updateCommentVC.postId = postId
        }
    }
    
    func getComments(with url: String)
    {
        guard let url = URL(string: url) else { return }

        AF.request(url).responseJSON { [weak self] response in
            switch response.result {
                case .success(let data):
                    self?.comments = JSON(data).arrayValue
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    @IBAction func unwindToAllComment(_ unwindSegue: UIStoryboardSegue)
    {
        tableView.reloadData()
    }
    
    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return comments.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = comments[indexPath.row]["name"].string?.firstCapitalized
        cell.detailTextLabel?.text = comments[indexPath.row]["body"].string?.firstCapitalized
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0
        zebraTable(with: cell, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            guard let id = comments[indexPath.row]["id"].int else { return }
            AF.request("\(URLConstants.urlDelComment)\(id)", method: .delete)
                .validate()
                .responseJSON { response in
                    if case .failure(let error) = response.result {
                        print(error)
                    }
                }
            comments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let postId = comments[indexPath.row]["postId"].int
        performSegue(withIdentifier: "goToAddComment", sender: postId)
    }
    
}
