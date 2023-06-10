//
//  CharacterData+CoreDataProperties.swift
//  MobileAppPartB_NicoleFabian
//
//  Created by Nicole  on 10/06/23.
//
//

import Foundation
import CoreData


extension CharacterData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterData> {
        return NSFetchRequest<CharacterData>(entityName: "CharacterData")
    }

    @NSManaged public var vision: String?
    @NSManaged public var constellation: String?
    @NSManaged public var card: Data?
    @NSManaged public var name: String?

}

extension CharacterData : Identifiable {

}
