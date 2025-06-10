//
//  PreferenceRepository.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import Foundation

protocol PreferenceRepository {
    func hasSignedInBefore() -> Bool
    func saveSignedInUserInfo(_ info: SignedInDto)
    func fetchSignedInUserInfo() throws -> SignedInDto
}
