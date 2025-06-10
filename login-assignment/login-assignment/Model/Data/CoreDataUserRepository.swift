//
//  UserRepositoryImplementation.swift
//  login-assignment
//
//  Created by 박진홍 on 6/11/25.
//

import Foundation

final class CoreDataUserRepository: UserRepository {
    private let coreDataStack: CoreDataStack<UserEntity>
    
    init(coreDataStack: CoreDataStack<UserEntity>) {
        self.coreDataStack = coreDataStack
    }
    
    func save(_ user: User) async throws {
        try await coreDataStack.createEntity { entity in
            entity.uuid = user.uuid
            entity.email = user.email.value
            entity.password = user.password.value
            entity.nickname = user.nickname.value
        }
    }
    
    func searchByEmail(_ email: Email ) async throws -> User {
        let entity: UserEntity = try await coreDataStack.fetchEntityByKeyValue(
            .email,
            value: email.value as CVarArg
        )
        return try UserMapper.mapEntityToModel(entity)
        
    }
    
    func deleteByUUID(_ uuid: UUID) async throws {
        <#code#>
    }
    
    func isEmailExists(_ email: String) async throws -> Bool {
        <#code#>
    }
    

}

enum UserMapper {
    static func mapEntityToModel(_ entity: UserEntity) throws -> User {
        guard let email = entity.email,
              let nickname = entity.nickname,
              let password = entity.password,
              let uuid = entity.uuid
        else {
            throw DataError.failedToMap
        }
        
        let emailInstance: Email = try Email(value: email)
        let passwordInstance: Password = try Password(value: password)
        let nicknameInstance: Nickname = try Nickname(value: nickname)
        
        return User(
            uuid: uuid,
            email: emailInstance,
            password: passwordInstance,
            nickname: nicknameInstance
        )
    }
}
