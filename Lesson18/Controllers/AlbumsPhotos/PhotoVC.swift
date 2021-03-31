import UIKit
import Alamofire
import AlamofireImage

class PhotoVC: UIViewController
{
    @IBOutlet weak var photoBig: UIImageView!
    @IBOutlet weak var labelPhoto: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadindLabel: UILabel!
    
    var text = ""
    var photoUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePhotoAbout()
        designImage(image: photoBig)
        labelPhoto.text = text.firstCapitalized
    }
    
    func configurePhotoAbout()
    {
        if let image = CacheManager.shared.imageCache.image(withIdentifier: photoUrl) {
            photoBig.image = image
            isHiddenElements(loadindLabel, activityIndicator, bool: true)
        } else {
            AF.request(photoUrl).responseImage { [weak self] response in
                if case .success(let image) = response.result {
                    isHiddenElements(self!.loadindLabel, self!.activityIndicator, bool: true)
                    self?.photoBig.image = image
                    guard let photoUrl = self?.photoUrl else { return }
                    CacheManager.shared.imageCache.add(image, withIdentifier: photoUrl)
                }
            }
        }
    }
}
