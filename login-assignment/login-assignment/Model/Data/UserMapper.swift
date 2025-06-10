//
//  UserMapper.swift
//  login-assignment
//
//  Created by 박진홍 on 6/11/25.
//

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
