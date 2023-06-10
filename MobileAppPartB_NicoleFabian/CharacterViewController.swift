//
//  CharacterViewController.swift
//  MobileAppPartB_NicoleFabian
//
//  Created by Nicole  on 10/06/23.
//

import UIKit
//imported to store the details in the coredata
import CoreData

class CharacterViewController: UIViewController {
    
    //temp variable which users want to see
    var Name: String!
    var Constellation: String!
    var Vision: String!
    
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
        hideElements(hidden: true)
        
        
        
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
        
        //to replace space with -
        let characterNameFormatted = characterName.lowercased().replacingOccurrences(of: " ", with: "-")
        let genshinURLString = "https://api.genshin.dev/characters/\(characterNameFormatted)"
        let genshinURLStringIcon = genshinURLString + "/card"

        print(genshinURLString)
        
        //created url object
        let genshinURL = URL(string: genshinURLString)
        let genshinURLIcon = URL(string: genshinURLStringIcon)
        
        //created request and passing the url object
        let genshinRequest = URLRequest(url: genshinURL!)
        let genshinRequestPic = URLRequest(url: genshinURLIcon!)
        
        let task = URLSession.shared.dataTask(with: genshinRequest) { (data, response, error) in
            if error == nil {
                // Parsing the JSON data
                let jsonData = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
             
                
                self.Name = jsonData["name"] as? String
                self.Constellation = jsonData["constellation"] as? String
                self.Vision = jsonData["vision"] as? String
                
                DispatchQueue.main.async { [self] in
                    // Update UI on the main queue
                    characterNameTextField.text = Name
                    constellationTextField.text = Constellation
                    visionTextField.text = Vision
                }
            }
        }
        task.resume()
        
        
        //getting the character icon requires additional /icon in url
        let pictureTask = URLSession.shared.dataTask(with: genshinRequestPic) {
            (data, response, error)
            in
            if error == nil {
                if let image = UIImage(data: data!) {
                    DispatchQueue.main.async {
                        self.characterImageView.image = image
                        self.hideElements(hidden: false)
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.hideElements(hidden: true)
                        // Show alert message on the main queue
                        self.showMessage(message: "No matching character found", buttonCaption: "Please try again", controller: self)
                    }
                }
            }
        }
        pictureTask.resume()
    }
    
    
    @IBAction func saveCharacterInfoButton(_ sender: UIButton) {
//        //for coredata implementation
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        //object context to read and write in db
//        let context = delegate.persistentContainer.viewContext
//
//        //for inserting new object
//        //(forEntityName: "DatabaseName")
//        let characterData = NSEntityDescription.insertNewObject(forEntityName: "Character", into:context) as! Character
//        //assigning the values from the coredata to the variables
//        characterData.name = Name
//        flickrData.width = Width
//        flickrData.title = Title
//
//        //saving image to binary form
//        let imageData = imagePicView.image?.pngData()
//        flickrData.pic = imageData
//
//        //saving it to db
//        do {
//            try context.save()
//            print("Data inserted successfully!")
//        }catch {
//            print("Data insertion error")
//        }
    }
    
    
    //MARK: other functions
    func hideElements (hidden: Bool) {
        characterNameLabel.isHidden = hidden
        characterNameTextField.isHidden = hidden
        visionLabel.isHidden = hidden
        visionTextField.isHidden = hidden
        constellationLabel.isHidden = hidden
        constellationTextField.isHidden = hidden
        characterImageView.isHidden = hidden
    }
    
    func showMessage(message: String, buttonCaption: String, controller: UIViewController)
    {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonCaption, style: .default)
        alert.addAction(action)
        controller.present(alert, animated: true)
    }
}



