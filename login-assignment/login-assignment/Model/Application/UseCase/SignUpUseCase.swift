//
//  SignInUseCase.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

struct SignUpUseCase {
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute(user: SignUpDto) async throws {
        let user: User = try UserFactory.createUser(by: user)
        
        if try await userRepository.isEmailExists(user.email.value) {
            throw UseCaseError.emailAlreadyExists
        }
        
        try await userRepository.save(user)
    }
}
