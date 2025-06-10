//
//  Password.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

struct Password {
    let value: String

    init(value: String) throws {
        do {
            guard try PasswordRule.validate(value) else {
                throw DomainError.invalidPassword
            }
        } catch {
            throw error
        }
        self.value = value
    }
}
