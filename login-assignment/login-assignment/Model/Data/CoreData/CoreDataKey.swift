//
//  PropertyKeys.swift
//  login-assignment
//
//  Created by 박진홍 on 6/11/25.
//

import CoreData

struct CoreDataKey<T: NSManagedObject> {
    let name: String
}

extension CoreDataKey where T == UserEntity {
    static let uuid = CoreDataKey<UserEntity>(name: "uuid")
    static let email = CoreDataKey<UserEntity>(name: "email")
    static let password = CoreDataKey<UserEntity>(name: "password")
    static let nickname = CoreDataKey<UserEntity>(name: "nickname")
}
