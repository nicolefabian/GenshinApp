//
//  SavedCharactersTableViewController.swift
//  MobileAppPartB_NicoleFabian
//
//  Created by Nicole  on 10/06/23.
//

import UIKit
import CoreData

class SavedCharactersTableViewController: UITableViewController {
    
    
    @IBOutlet var characterTableView: UITableView!
    
    var genshinData = [CharacterData] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let del = UIApplication.shared.delegate as! AppDelegate
        let context = del.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject> (entityName: "CharacterData")
        genshinData = try! context.fetch(request) as! [CharacterData]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(genshinData.count)
        return genshinData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCells", for: indexPath) as! SavedCharactersTableViewCell

        cell.characterNameLabel.text = genshinData[indexPath.row].name
        let cardPic = genshinData[indexPath.row].card
        cell.characterImageView.image = UIImage(data: cardPic!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected data from the table view
        let selectedCharacter = genshinData[indexPath.row]
        
        // Perform the segue and passing the data
        performSegue(withIdentifier: "characterDetailSegue", sender: selectedCharacter)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterDetailSegue" {
            let destinationVC = segue.destination as! SavedCharacterDetailViewController
            let selectedData = sender as! CharacterData
            //selectedCharacter from SavedCharacterDetailViewController
            destinationVC.selectedCharacter = selectedData
            }
        }
    }
