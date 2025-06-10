//
//  Password.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

struct Password {
    let value: String
    
    init(value: String) throws {
        guard PasswordRule.validate(value) else {
            throw DomainError.invalidPassword
        }
        self.value = value
    }
}
