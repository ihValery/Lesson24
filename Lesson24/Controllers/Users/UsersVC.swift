import UIKit
import Alamofire
import SwiftyJSON

class UsersVC: UITableViewController
{
    private var users: [JSON] = []

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let desination = segue.destination as? DetailViewController,
            let user = sender as? JSON {
            desination.user = user
        }
    }
    
    func fetchData()
    {
        guard let url = URL(string: URLConstants.urlUsers) else { return }

        AF.request(url).responseJSON { [weak self] response in
            switch response.result {
                case .success(let data):
                    self?.users = JSON(data).arrayValue
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }

    // MARK: - TableSiewSataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = users[indexPath.row]["name"].string?.uppercased()
        cell.detailTextLabel?.text = users[indexPath.row]["username"].string
        zebraTable(with: cell, indexPath: indexPath)
        return cell
    }

    // MARK: - TableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let user = users[indexPath.row]
        performSegue(withIdentifier: "showDetail", sender: user)
    }
}
