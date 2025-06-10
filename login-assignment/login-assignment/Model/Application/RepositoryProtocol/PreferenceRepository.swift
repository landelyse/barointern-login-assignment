//
//  PreferenceRepository.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

protocol PreferenceRepository {
    func hasSignedInBefore() -> Bool
    func saveSignedInUserName(nickname: String)
    func fetchSignedInUserName() throws -> String
}
