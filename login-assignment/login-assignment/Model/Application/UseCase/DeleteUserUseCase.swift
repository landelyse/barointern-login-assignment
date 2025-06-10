//
//  DeleteUser.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

final class DeleteUserUseCase {
    private let userRepository: UserRepository
    private let preferenceRepository: PreferenceRepository
    
    init(userRepository: UserRepository, preferenceRepository: PreferenceRepository) {
        self.userRepository = userRepository
        self.preferenceRepository = preferenceRepository
    }
    
    func execute() async throws {
        let signedInDto: SignedInDto = try preferenceRepository.fetchSignedInUserInfo()
        preferenceRepository.deleteSignedInUserInfo()
        try await userRepository.deleteByUUID(signedInDto.uuid)
    }
}
