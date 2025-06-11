//
//  DataError.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import Foundation

enum DataError: LocalizedError {
    case failedToCreateEntity(String)
    case coreDataEntityNotFound
    case failedToMap

    var errorDescription: String? {
        switch self {
        case .failedToCreateEntity(let name): "Entity 생성에 실패했습니다. EntityName: \(name)"
        case .coreDataEntityNotFound: "Entity를 찾을 수 없습니다."
        case .failedToMap: "모델 매핑에 실패했습니다."
        }
    }
}
