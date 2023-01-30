//
//  GameData+CoreDataProperties.swift
//  GameIMDB
//
//  Created by Burak Erden on 27.01.2023.
//
//

import Foundation
import CoreData


extension GameData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameData> {
        return NSFetchRequest<GameData>(entityName: "GameData")
    }

    @NSManaged public var name: String?
    @NSManaged public var released: String?
    @NSManaged public var rating: Double
    @NSManaged public var backgroundImage: String?
    @NSManaged public var gameId: Double

}

extension GameData : Identifiable {

}
