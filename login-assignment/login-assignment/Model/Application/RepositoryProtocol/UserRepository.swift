//
//  UserRepository.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import Foundation

protocol UserRepository {
    func save(user: User) throws
    func search(uuid: UUID) throws -> User
    func delete(uuid: UUID) throws
}
