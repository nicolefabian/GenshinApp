//
//  CharacterViewController.swift
//  MobileAppPartB_NicoleFabian
//
//  Created by Nicole  on 10/06/23.
//

import UIKit

class CharacterViewController: UIViewController {
    
    
    @IBOutlet weak var searchCharacterTextField: UITextField!
    
    
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterNameTextField: UITextField!
    
    
    @IBOutlet weak var constellationLabel: UILabel!
    @IBOutlet weak var constellationTextField: UITextField!
    
    
    @IBOutlet weak var visionLabel: UILabel!
    @IBOutlet weak var visionTextField: UITextField!
    @IBOutlet weak var characterImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Hide labels and text fields
        
        
        
    }
    
    @IBAction func searchCharacterButton(_ sender: UIButton) {
        
        let userInput = searchCharacterTextField.text!
        if userInput.isEmpty {
            showMessage(message: "Search cannot be empty", buttonCaption: "Invalid search", controller: self)
            
        } else {
            // Call the fetchCharacterData method
            fetchCharacterData(characterName: userInput)
        }
    }
    
    func fetchCharacterData(characterName: String) {
        print(characterName)
        let genshinURLString = "https://api.genshin.dev/characters/\(characterName.lowercased())"
        let genshinURLStringPicture = "https://api.genshin.dev/characters/\(characterName.lowercased())/icon"
        
        //created url object
        let genshinURL = URL(string: genshinURLString)
        let genshinURLPic = URL(string: genshinURLStringPicture)
        
        //created request and passing the url object
        let genshinRequest = URLRequest(url: genshinURL!)
        let genshinRequestPic = URLRequest(url: genshinURLPic!)
        
        let task = URLSession.shared.dataTask(with: genshinRequest){
            (data,response,error)
            in
            if error == nil {
                //breaking down the api url
                let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                //print(jsonData)
                let name = jsonData["name"] as! String
                let constellation = jsonData["constellation"] as! String
                let vision = jsonData["vision"] as! String
                
                DispatchQueue.main.async {
                    // Update UI on the main queue
                    self.characterNameTextField.text = name
                    self.constellationTextField.text = constellation
                    self.visionTextField.text = vision
                }
            }
        }
        task.resume()
        
        
        let pictureTask = URLSession.shared.dataTask(with: genshinRequestPic) {
            (data, response, error)
            in
            if error == nil {
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.characterImageView.image = image
                }
            }
        }
        pictureTask.resume()

    }
    
    func hideElements (hidden: Bool) {
        characterNameLabel.isHidden = hidden
        characterNameTextField.isHidden = hidden
        visionLabel.isHidden = hidden
        visionTextField.isHidden = hidden
        constellationLabel.isHidden = hidden
        constellationTextField.isHidden = hidden
    }
    
    func showMessage(message: String, buttonCaption: String, controller: UIViewController)
    {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonCaption, style: .default)
        alert.addAction(action)
        controller.present(alert, animated: true)
    }
}



