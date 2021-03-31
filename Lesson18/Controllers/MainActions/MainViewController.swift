import UIKit

//Подпишем перечисление к стрингу, дабы задать красивое отображение на кнопках ))
//CaseIterable позволяет из перечисления сделать массив, для дальнейшей работы
enum UserActions: String, CaseIterable
{
    case downloadImage = "Download Image"
    case seeAllUser = "See all user"
}

class MainViewController: UICollectionViewController
{
    //Массив наших Actions из всех case
    private let userActions = UserActions.allCases
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setSizeCell(collectionView: collectionView)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "Users" {
            let usersVC = segue.destination as! UsersVC
            usersVC.fetchData()
        }
    }
    
    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserActionCell", for: indexPath) as! UserActionCell
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
        designCell(with: cell)
        return cell
    }

    // MARK: - UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let userAction = userActions[indexPath.item]
        switch userAction {
        case .downloadImage:
            performSegue(withIdentifier: "ShowImage", sender: self)
        case .seeAllUser:
            performSegue(withIdentifier: "Users", sender: self)
        }
    }
}
