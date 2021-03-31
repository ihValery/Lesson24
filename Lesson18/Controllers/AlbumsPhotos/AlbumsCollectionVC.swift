import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class AlbumsCollectionVC: UICollectionViewController
{
    var album: JSON!
    var photos: [JSON] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getImage()
        setSizeCellCollection(collectionView: collectionView)
        title = "Album № \(album["id"])"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard let photoVC = segue.destination as? PhotoVC else { return }
        let photo = sender as! JSON
        photoVC.text = photo["title"].string ?? "no title"
        photoVC.photoUrl = photo["url"].string ?? "error URL"
    }
    
    func getImage()
    {
        guard let albumId = album["id"].int else { return }
        guard let url = URL(string: "\(URLConstants.urlPhotos)\(albumId)") else { return }
        
        AF.request(url).responseJSON { [weak self] response in
            switch response.result{
                case .success(let data):
                    self?.photos = JSON(data).arrayValue
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    //MARK:  - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAlbums", for: indexPath) as! AlbumsCVCell
        guard let thumbnailUrl = photos[indexPath.item]["thumbnailUrl"].string else { return cell }
        cell.getPreview(with: thumbnailUrl)
        designCell(with: cell)
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let photo = photos[indexPath.item]
        performSegue(withIdentifier: "goToPhoto", sender: photo)
    }
}
