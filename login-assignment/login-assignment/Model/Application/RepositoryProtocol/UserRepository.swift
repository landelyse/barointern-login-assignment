//
//  UserRepository.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import Foundation

protocol UserRepository {
    func save(_ user: User) async throws
    func searchByEmail(_ email: Email) async throws -> User
    func deleteByUUID(_ uuid: UUID) async throws
    func isEmailExists(_ email: Email) async throws -> Bool
}
