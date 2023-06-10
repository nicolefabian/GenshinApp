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
    
    /*list of characters available in the genshin API
     
     ["albedo","aloy","amber","arataki-itto","ayaka","ayato","barbara","beidou","bennett","chongyun","collei","diluc","diona","eula","fischl","ganyu","gorou","hu-tao","jean","kaeya","kazuha","keqing","klee","kokomi","kuki-shinobu","lisa","mona","ningguang","noelle","qiqi","raiden","razor","rosaria","sara","sayu","shenhe","shikanoin-heizou","sucrose","tartaglia","thoma","tighnari","traveler-anemo","traveler-dendro","traveler-electro","traveler-geo","venti","xiangling","xiao","xingqiu","xinyan","yae-miko","yanfei","yelan","yoimiya","yun-jin","zhongli"]
    */
    @IBAction func searchCharacterButton(_ sender: UIButton) {
        
        let userInput = searchCharacterTextField.text!
        if userInput.isEmpty {
            showMessage(msg: "Search cannot be empty", controller: self)
            
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
                        self.showMessage(msg: "No matching character found", controller: self)
                    }
                }
            }
        }
        pictureTask.resume()
    }
    
    
    @IBAction func saveCharacterInfoButton(_ sender: UIButton) {
        let formattedSearchedText = searchCharacterTextField.text!.capitalized(with: Locale.current)

        //for coredata implementation
        let delegate = UIApplication.shared.delegate as! AppDelegate
        //object context to read and write in db
        let context = delegate.persistentContainer.viewContext

        //for inserting new object
        //(forEntityName: "DatabaseName")
        let character = NSEntityDescription.insertNewObject(forEntityName: "CharacterData", into:context) as! CharacterData
       // assigning the values from the coredata to the variables
        character.name = Name
        character.constellation = Constellation
        character.vision = Vision

        //saving image to binary form
        let characterImageData = characterImageView.image?.pngData()
        character.card = characterImageData

        //saving it to db
        do {
            try context.save()
            showMessage(msg: "\(formattedSearchedText) details are saved successfully", controller: self)
        }catch {
            print("Data insertion error")
        }
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
    
    func showMessage (msg: String, controller:UIViewController){
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert);
        let validateAction = UIAlertAction(title: "OK", style: .default) {
            action in controller.dismiss(animated: true, completion: nil)
            }
        alert.addAction(validateAction)
        controller.present(alert, animated: true, completion: nil)
    }
}



