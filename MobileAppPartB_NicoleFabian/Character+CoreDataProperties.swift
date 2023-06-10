//
//  Character+CoreDataProperties.swift
//  MobileAppPartB_NicoleFabian
//
//  Created by Nicole  on 10/06/23.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }

    @NSManaged public var name: String?
    @NSManaged public var constellation: String?
    @NSManaged public var vision: String?
    @NSManaged public var icon: Data?

}

extension Character : Identifiable {

}
