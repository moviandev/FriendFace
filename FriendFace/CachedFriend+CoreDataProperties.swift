//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Matheus Viana on 16/03/23.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var cachedUser: CachedUser?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    public var wrappedUser: CachedUser {
        cachedUser ?? CachedUser()
    }
}

extension CachedFriend : Identifiable {

}
