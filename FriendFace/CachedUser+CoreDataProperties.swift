//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Matheus Viana on 16/03/23.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var company: String?
    @NSManaged public var age: Int16
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var cachedFriends: NSSet?
    
    public var wrappedId: UUID {
        id ?? UUID()
    }
    
    public var wrappedIsActive: Bool {
        isActive ?? false
    }
    
    public var wrappedName: String {
        name ?? "Unknown"
    }
    
    public var wrappedCompany: String {
        company ?? "Unknown"
    }
    
    public var wrappedAge: Int {
        age != nil ? Int(age) : 0
    }
    
    public var wrappedEmail: String {
        email ?? "Unknown"
    }
    
    public var wrappedAddress: String {
        address ?? "Unknown"
    }
    
    public var wrappedAbout: String {
        about ?? "Unknown"
    }
    
    public var wrappedRegistered: Date {
        registered ?? Date.now
    }
    
    public var wrappedTags: [String] {
        tags != nil ? tags.componentsSeparatedByString(",") : []
    }
    
    public var wrappedFriends: [CachedFriend] {
        let set = cachedFriends as? Set<CachedFriend> ?? []
        
        set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for cachedFriends
extension CachedUser {

    @objc(addCachedFriendsObject:)
    @NSManaged public func addToCachedFriends(_ value: CachedFriend)

    @objc(removeCachedFriendsObject:)
    @NSManaged public func removeFromCachedFriends(_ value: CachedFriend)

    @objc(addCachedFriends:)
    @NSManaged public func addToCachedFriends(_ values: NSSet)

    @objc(removeCachedFriends:)
    @NSManaged public func removeFromCachedFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
