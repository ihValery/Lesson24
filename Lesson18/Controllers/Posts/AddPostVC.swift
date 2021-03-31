import UIKit
import Alamofire
import SwiftyJSON

class AddPostVC: UIViewController
{
    var user: JSON!
    
    @IBOutlet weak var titlePost: UITextField!
    @IBOutlet weak var bodyPost: UITextView!
    @IBOutlet weak var lineDesign: UIView!
    @IBOutlet weak var addPostBttn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        designButton(button: addPostBttn)
        designView(view: lineDesign)
        bodyPost.delegate = self
        buttonOnOff(with: addPostBttn, bool: false)
    }
    
    @IBAction func titlePostAction(_ sender: Any)
    {
        buttonOnOff(with: addPostBttn, bool: titlePost.text != "")
    }
    
    @IBAction func addPostAction(_ sender: Any)
    {
        guard let userId = user["id"].int else { return }
        guard let title = titlePost.text else { return }
        guard let body = bodyPost.text else { return }
        
        let post: Parameters = ["userId": userId,
                                "title": title,
                                "body": body]
        
        AF.request(URLConstants.urlPosts, method: .post, parameters: post, encoding: JSONEncoding.default)
            .responseJSON { /*[weak self]*/ response in
                switch response.result {
                    case .success(let data):
                        print(JSON(data))
                    case .failure(let error):
                        print(error)
                }
        }
        navigationController?.popViewController(animated: true)
    }
}
