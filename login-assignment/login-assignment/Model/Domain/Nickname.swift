//
//  Nickname.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import Foundation

struct Nickname: Equatable {
    let value: String
    
    init(value: String) throws {
        guard NicknameRule.validate(value) else {
            throw DomainError.invalidNickname
        }
        self.value = value
    }
}
