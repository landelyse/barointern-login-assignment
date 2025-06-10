//
//  User.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import Foundation

struct User {
    let uuid: UUID
    let email: Email
    let password: Password
    let nickname: Nickname
    
    func isCorrectPassword(_ input: Password) -> Bool {
        return self.password == input
    }
}
