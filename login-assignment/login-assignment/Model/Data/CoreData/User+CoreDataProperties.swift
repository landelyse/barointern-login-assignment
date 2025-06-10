//
//  User+CoreDataProperties.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var nickname: String?

}

extension User : Identifiable {

}
