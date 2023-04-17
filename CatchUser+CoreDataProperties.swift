//
//  CatchUser+CoreDataProperties.swift
//  FriendFace2
//
//  Created by Adelaida Gomez Vieco on 26/03/23.
//
//

import Foundation
import CoreData


extension CatchUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatchUser> {
        return NSFetchRequest<CatchUser>(entityName: "CatchUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registred: String?
    @NSManaged public var friends: NSSet?
    
    var wrappedName: String {
        name ?? "Unknown"
    }
    
    var wrappedCompany: String {
        company ?? "Unknown"
    }
    
    var wrappedAbout: String {
        about ?? "Unknown"
    }
    
    var wrappedEmail: String {
        email ?? "Unknown"
    }
    
    var wrappedRegistred: String {
        registred ?? "Unknown"
    }
    
    var wrappedID: UUID {
        id ?? UUID()
    }

    
    public var friendsArray: [CatchFriend] {
        let set = friends as? Set<CatchFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for friends
extension CatchUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CatchFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CatchFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CatchUser : Identifiable {

}
