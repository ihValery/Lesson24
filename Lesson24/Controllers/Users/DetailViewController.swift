import UIKit
import SwiftyJSON

class DetailViewController: UIViewController
{
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var streetLbl: UILabel!
    @IBOutlet weak var suitLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var zipCodeLbl: UILabel!

    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var bsLbl: UILabel!
    @IBOutlet weak var chLbl: UILabel!

    @IBOutlet weak var bttnPost: UIButton!
    
    var user: JSON!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        designButton(button: bttnPost)
        
        nameLbl.text = user["name"].string
        usernameLbl.text = user["username"].string
        emailLbl.text = user["email"].string
        phoneLbl.text = user["phone"].string
        websiteLbl.text = user["website"].string
        streetLbl.text = user["address"]["street"].string
        suitLbl.text = user["address"]["suite"].string
        cityLbl.text = user["address"]["city"].string
        zipCodeLbl.text = user["address"]["zipcode"].string
        companyLbl.text = user["company"]["name"].string
        bsLbl.text = user["company"]["bs"].string
        chLbl.text = user["company"]["catchPhrase"].string
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        guard segue.identifier == "goToPosts" else { return }
        if let postsVC = segue.destination as? PostsTableViewController {
            postsVC.user = user
        }
    }
}
