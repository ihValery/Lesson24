import UIKit

public func zebraTable(with cell: UITableViewCell, indexPath: IndexPath)
{
    let backgroundView = UIView()
    backgroundView.backgroundColor = UIColor.red
    cell.selectedBackgroundView = backgroundView
    
    switch indexPath.row.isMultiple(of: 2) {
        case false:
            cell.contentView.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        default:
            cell.contentView.backgroundColor = .white
    }
}

public func designCell(with cell: UICollectionViewCell)
{
    cell.contentView.layer.cornerRadius = 13
    cell.contentView.layer.borderWidth = 1
    cell.contentView.layer.borderColor = UIColor.clear.cgColor
    cell.contentView.layer.masksToBounds = true

    cell.layer.cornerRadius = 13
    cell.layer.shadowColor = UIColor.black.cgColor
    cell.layer.shadowOffset = CGSize(width: 0, height: 2)
    cell.layer.shadowRadius = 4
    cell.layer.shadowOpacity = 0.4
    cell.layer.masksToBounds = false
    cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
}

public extension StringProtocol
{
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

public func designImage(image: UIImageView)
{
    image.layer.shadowColor = UIColor.black.cgColor
    image.layer.shadowOffset = CGSize(width: 0, height: 2)
    image.layer.shadowRadius = 4
    image.layer.shadowOpacity = 0.5
    image.layer.masksToBounds = false
}

public func designView(view: UIView)
{
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 4
    view.layer.shadowOpacity = 0.5
    view.layer.masksToBounds = false
}

public func designButton(button: UIButton)
{
    button.layer.cornerRadius = 13
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOffset = CGSize(width: 0, height: 2)
    button.layer.shadowRadius = 4
    button.layer.shadowOpacity = 0.5
    button.layer.masksToBounds = false
}

public func setSizeCell(collectionView: UICollectionView)
{
    let layout = UICollectionViewFlowLayout()
    let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
   
    layout.minimumLineSpacing = sectionInserts.top
    layout.itemSize = CGSize(width: collectionView.frame.width - 60, height: sectionInserts.top * 4)
    layout.sectionInset = sectionInserts
    collectionView.collectionViewLayout = layout
}

public func setSizeCellCollection(collectionView: UICollectionView)
{
    let layout = UICollectionViewFlowLayout()
    let itemsPerRow: CGFloat = 3
    let sectionInserts = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let paddigWidht = sectionInserts.top * (itemsPerRow + 1)
    let availableWigth = collectionView.frame.width - paddigWidht
    let widhtPerItem = availableWigth / itemsPerRow
    
    layout.minimumLineSpacing = 10
    layout.itemSize = CGSize(width: widhtPerItem, height:widhtPerItem)
    layout.sectionInset = sectionInserts
    collectionView.collectionViewLayout = layout
}

public func isHiddenElements(_ label: UILabel, _ indicator: UIActivityIndicatorView, bool: Bool)
{
    indicator.isHidden = bool
    label.isHidden = bool
    bool ? indicator.stopAnimating() : indicator.startAnimating()
}

public func buttonOnOff(with button: UIButton, bool: Bool)
{
        button.isEnabled = bool
        button.alpha = bool ? 1 : 0.3
}

extension AddPostVC: UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if bodyPost.text == "The body of the post must contain at least 20 characters" {
            bodyPost.text = nil
            bodyPost.textColor = .black
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        buttonOnOff(with: addPostBttn, bool: textView.text.count > 20 && titlePost.text != "")
        return true
    }
}

extension UpdateCommentVC: UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if bodyPost.text == "The body of the comment must contain at least 20 characters" {
            bodyPost.text = nil
            bodyPost.textColor = .black
        }
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        buttonOnOff(with: addCommentBttn, bool: textView.text.count > 20 && titlePost.text != "")
        return true
    }
}
