import UIKit
import Alamofire
import SwiftyJSON

class UpdateCommentVC: UIViewController
{
//    var comments: JSON!
    var postId: Int!
    
    @IBOutlet weak var titlePost: UITextField!
    @IBOutlet weak var bodyPost: UITextView!
    @IBOutlet weak var lineDesign: UIView!
    @IBOutlet weak var addCommentBttn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        designButton(button: addCommentBttn)
        designView(view: lineDesign)
        bodyPost.delegate = self
        buttonOnOff(with: addCommentBttn, bool: false)
    }
    
    @IBAction func titlePostAction(_ sender: Any)
    {
        buttonOnOff(with: addCommentBttn, bool: titlePost.text != "")
    }
    
    @IBAction func addCommentAction(_ sender: Any)
    {
        guard let postId = postId else { return }
        guard let title = titlePost.text else { return }
        guard let body = bodyPost.text else { return }
        
        let post: Parameters = ["postId": postId,
                                "title": title,
                                "body": body]
        
        AF.request(URLConstants.urlUplComment, method: .post, parameters: post, encoding: JSONEncoding.default)
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
