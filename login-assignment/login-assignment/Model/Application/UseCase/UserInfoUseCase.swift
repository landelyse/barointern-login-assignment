//
//  UserInfoUseCase.swift
//  login-assignment
//
//  Created by 박진홍 on 6/15/25.
//

final class UserInfoUseCase {
    private let preferenceRepository: PreferenceRepository
    
    init(preferenceRepository: PreferenceRepository) {
        self.preferenceRepository = preferenceRepository
    }
    
    func getNickName() throws -> String {
        try preferenceRepository.fetchSignedInUserInfo().nickname
    }
}
