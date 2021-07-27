//
//  FriendCell.swift
// PersonalProfile
//
//  Created by Usha Natarajan on 7/26/21.
//

import UIKit

class FriendCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let nibName = "FriendCell"
    
    var friend : Friend? {
        didSet {
            guard let item = friend  else  { return }
            DispatchQueue.main.async {
                self.photoImage.image = UIImage(named: item.pictureUrl ?? "")
                self.photoImage.layer.masksToBounds = false
                self.photoImage.clipsToBounds = true
                self.photoImage.layer.cornerRadius = self.photoImage.frame.size.height / 2
                self.photoImage.layer.borderWidth = 0.5
                self.photoImage.layer.borderColor = UIColor.gray.cgColor
            }
            self.nameLabel.text = item.name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.photoImage.layer.cornerRadius = 50
        self.photoImage.clipsToBounds = true
    }

  
}
