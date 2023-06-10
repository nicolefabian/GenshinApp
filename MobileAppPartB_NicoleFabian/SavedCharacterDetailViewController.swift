//
//  SavedCharacterDetailViewController.swift
//  MobileAppPartB_NicoleFabian
//
//  Created by Nicole  on 10/06/23.
//

import UIKit

class SavedCharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var visionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var constellationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var selectedCharacter : CharacterData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = "\(selectedCharacter.name!) details"
        nameLabel.text = "Name: \(selectedCharacter.name!)"
        constellationLabel.text = "Constellation: \(selectedCharacter.constellation!)"
        visionLabel.text = "Vision: \(selectedCharacter.vision!)"
        let genshinCard = selectedCharacter.card
        imageView?.image = UIImage(data: genshinCard!)
    }
}
