//
//  UserDefaultsPreferenceRepository.swift
//  login-assignment
//
//  Created by 박진홍 on 6/11/25.
//

import Foundation

final class UserDefaultsPreferenceRepository: PreferenceRepository {
    let userDefaults: UserDefaults = UserDefaults.standard
    
    func hasSignedInBefore() -> Bool {
        userDefaults.bool(forKey: PreferenceKey.isSignedIn)
    }
    
    func saveSignedInUserInfo(_ info: SignedInDto) {
        userDefaults.set(true, forKey: PreferenceKey.isSignedIn)
        userDefaults.set(info.uuid.uuidString, forKey: PreferenceKey.id)
        userDefaults.set(info.nickname, forKey: PreferenceKey.nickname)
    }
    
    func fetchSignedInUserInfo() throws -> SignedInDto {
        guard let uuidString: String = userDefaults.string(forKey: PreferenceKey.id),
              let uuid: UUID = UUID(uuidString: uuidString),
              let nickname: String = userDefaults.string(forKey: PreferenceKey.nickname)
        else {
            throw DataError.failedToFetchSignedInInfo
        }
        
        return SignedInDto(uuid: uuid, nickname: nickname)
    }
    
    func deleteSignedInUserInfo() {
        userDefaults.removeObject(forKey: PreferenceKey.isSignedIn)
        userDefaults.removeObject(forKey: PreferenceKey.id)
        userDefaults.removeObject(forKey: PreferenceKey.nickname)
    }
}

private enum PreferenceKey {
    static let isSignedIn: String = "isSignedIn"
    static let id: String = "uuid"
    static let nickname: String = "nickname"
}
