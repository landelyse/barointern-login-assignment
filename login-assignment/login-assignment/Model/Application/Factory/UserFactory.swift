//
//  UserMapper.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import Foundation

enum UserFactory {
    static func create(by input: SignUpDto) throws -> User {
        let email: Email = try Email(value: input.email)
        let password: Password = try Password(value: input.password)
        let nickname: Nickname = try Nickname(value: input.nickname)

        let user: User = User(
            uuid: UUID(),
            email: email,
            password: password,
            nickname: nickname
        )

        return user
    }
}
