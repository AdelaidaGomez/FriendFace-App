//
//  CatchFriend+CoreDataProperties.swift
//  FriendFace2
//
//  Created by Adelaida Gomez Vieco on 26/03/23.
//
//

import Foundation
import CoreData


extension CatchFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatchFriend> {
        return NSFetchRequest<CatchFriend>(entityName: "CatchFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CatchUser?
    
    var wrappedName: String {
        name ?? "Unknown"
    }

}

extension CatchFriend : Identifiable {

}
