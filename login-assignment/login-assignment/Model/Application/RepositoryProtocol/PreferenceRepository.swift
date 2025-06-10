//
//  PreferenceRepository.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import Foundation

protocol PreferenceRepository {
    func hasSignedInBefore() -> Bool
    func saveSignedInUserName(_ nickname: String)
    func saveSignedInUserUUID(_ uuid: UUID)
    func fetchSignedInUserName() throws -> String
    func fetchSignedInUserUUID() -> UUID
}
