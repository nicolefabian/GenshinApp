//
//  SavedCharactersTableViewCell.swift
//  MobileAppPartB_NicoleFabian
//
//  Created by Nicole  on 10/06/23.
//

import UIKit

class SavedCharactersTableViewCell: UITableViewCell {

    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
