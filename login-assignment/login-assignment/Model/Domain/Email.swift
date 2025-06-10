//
//  Email.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

struct Email: Equatable {
    let value: String
    
    init(value: String) throws {
        guard EmailRule.validate(value) else {
            throw DomainError.invalidEmail
        }
        self.value = value
    }
}
