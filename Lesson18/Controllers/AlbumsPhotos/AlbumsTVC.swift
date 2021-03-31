import UIKit
import Alamofire
import SwiftyJSON

class AlbumsTVC: UITableViewController
{
    var user: JSON!
    var albums: [JSON] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToCollectionAlbums" {
            let photosCollectionVC = segue.destination as? AlbumsCollectionVC
            let album = sender as? JSON
            photosCollectionVC?.album = album
        }
        
    }
    
    private func getData()
    {
        guard let userId = user["id"].int else { return }
        guard let url = URL(string: "\(URLConstants.urlAlbums)\(userId)") else { return }
        
        AF.request(url).responseJSON { [weak self] response in
            switch response.result {
                case .success(let data):
                    self?.albums = JSON(data).arrayValue
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }

    // MARK: - TableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cellAlbums")
        cell.textLabel?.text = albums[indexPath.row]["title"].stringValue.firstCapitalized
        cell.textLabel?.numberOfLines = 0
        let detailText = (albums[indexPath.row]["id"].int ?? 0).description
        cell.detailTextLabel?.text = "Album № \(detailText)"
        zebraTable(with: cell, indexPath: indexPath)
        return cell
    }
    
    // MARK: - TableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let album = albums[indexPath.row]
        performSegue(withIdentifier: "goToCollectionAlbums", sender: album)
    }
}
