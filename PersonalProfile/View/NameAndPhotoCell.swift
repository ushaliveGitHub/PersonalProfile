//
//  NameAndPhotoCell.swift
//  PersonalProfile
//
//  Created by Usha Natarajan on 7/26/21.
//

import UIKit

class NameAndPhotoCell: UITableViewCell {
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var namelabel: UILabel!
    static let nibName = "NameAndPhotoCell"
    
    var item : ProfileViewModelItem? {
        didSet {
            guard let item = item as? ProfileNameAndPicture else  { return }
            DispatchQueue.main.async {
                self.photoImage.image = UIImage(named: item.pictureUrl)
                self.photoImage.layer.masksToBounds = false
                self.photoImage.clipsToBounds = true
                self.photoImage.layer.cornerRadius = self.photoImage.frame.size.height / 2
                self.photoImage.layer.borderWidth = 0.5
                self.photoImage.layer.borderColor = UIColor.gray.cgColor
            }
            self.namelabel.text = item.userName
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
