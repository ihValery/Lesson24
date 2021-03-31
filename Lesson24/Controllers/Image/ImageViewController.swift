import UIKit
import Alamofire
import AlamofireImage

class ImageViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        isHiddenElements(loadingLabel, activityIndicator, bool: false)
        downloadImage()
    }
    
    private func downloadImage()
    {
        guard let url = URL(string: URLConstants.urlBigImage) else { return }
        
        if let image = CacheManager.shared.imageCache.image(withIdentifier: URLConstants.urlBigImage) {
            imageView.image = image
            isHiddenElements(loadingLabel, activityIndicator, bool: true)
        } else {
            AF.request(url)
            .downloadProgress { [weak self] progress in
                let progress = Float(progress.fractionCompleted)
                self?.progressView.setProgress(progress, animated: true)
            }
            .responseImage { [weak self] response in
                switch response.result {
                    case .success(let image):
                        
                        //MARK: - проверку если выйти и не догрузить картинку - краш
                        
                        isHiddenElements(self!.loadingLabel, self!.activityIndicator, bool: true)
                        self?.progressView.isHidden = true
                        self?.imageView.image = image
                        guard let bigImage = self?.imageView.image else { return }
                        CacheManager.shared.imageCache.add(bigImage, withIdentifier: URLConstants.urlBigImage)
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
}

