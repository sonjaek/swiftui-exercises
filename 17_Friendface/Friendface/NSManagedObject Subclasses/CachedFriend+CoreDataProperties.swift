//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Sonja Ek on 6.11.2022.
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
    @NSManaged public var user: CachedUser?
    
    var wrappedName: String {
        name ?? ""
    }
}

extension CachedFriend : Identifiable {

}
