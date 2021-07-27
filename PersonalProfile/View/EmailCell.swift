//
//  EmailAndAboutCell.swift
//  PersonalProfile
//
//  Created by Usha Natarajan on 7/26/21.
//

import UIKit

class EmailCell: UITableViewCell {
    @IBOutlet weak var emailLabel: UILabel!
    var isEmail: ProfileViewModelType = .email
    static let nibName = "EmailCell"
    
    var item: ProfileViewModelItem? {
        didSet {
            if isEmail == .email {
                guard let item  = item as? ProfileEmail else { return }
                self.emailLabel.text = item.email
            }else {
                guard let item  = item as? ProfileAbout else { return }
                self.emailLabel.text = item.about
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
