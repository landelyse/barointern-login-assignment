//
//  ModelError.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import Foundation

enum DomainError: LocalizedError {
    case invalidEmail
    case invalidPassword
    case invalidNickname
    case invalidUser
    
    var errorDescription: String? {
        switch self {
        case .invalidEmail: "잘못된 이메일입니다."
        case .invalidPassword: "잘못된 패스워드입니다."
        case .invalidNickname: "잘못된 닉네임입니다."
        case .invalidUser: "잘못된 유저 정보입니다."
        default: "도메인 문제가 발생했습니다."
        }
    }
}
