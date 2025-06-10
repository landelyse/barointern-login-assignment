//
//  SignedInUserDtoFactory.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

enum SignedInUserDtoFactory {
    static func create(by user: User) -> SignedInDto {
        return SignedInDto(uuid: user.uuid, nickname: user.nickname.value)
    }
}
