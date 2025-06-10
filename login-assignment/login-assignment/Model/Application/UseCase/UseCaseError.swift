//
//  UseCaseError.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import Foundation

enum UseCaseError: LocalizedError {
    case emailAlreadyExists
    case failedToSignIn
    case undefinedAction
    
    var errorDescription: String? {
        switch self {
        case .emailAlreadyExists: "이미 존재하는 이메일입니다."
        case .failedToSignIn: "로그인에 실패했습니다."
        default: "예기치 못한 동작으로 실패했습니다."
        }
    }
}
