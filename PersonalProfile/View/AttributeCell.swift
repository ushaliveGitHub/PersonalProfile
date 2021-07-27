//
//  EmailAndAboutCell.swift
//  PersonalProfile
//
//  Created by Usha Natarajan on 7/26/21.
//

import UIKit

class AttributeCell: UITableViewCell {
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    
    static let nibName = "AttributeCell"
    
    var item: ProfileAttributes? {
        didSet {
            guard let item = item else { return }
            self.keyLabel.text = item.key
            self.valueLabel.text = item.value
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
