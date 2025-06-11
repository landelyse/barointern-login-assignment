//
//  UserEntity+CoreDataProperties.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//
//

import Foundation
import CoreData

extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var nickname: String?
    @NSManaged public var password: String?
    @NSManaged public var uuid: UUID?

}
