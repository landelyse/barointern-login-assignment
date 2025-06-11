//
//  StartViewModel.swift
//  login-assignment
//
//  Created by 박진홍 on 6/11/25.
//

import Combine
import Foundation

@MainActor
final class StartViewModel {
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    private let navigateSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    var navigatePublisher: AnyPublisher<Void, Never> {
        navigateSubject.eraseToAnyPublisher()
    }
    
    init() {
        
    }
    
    func startButtonTapped() {
        navigateSubject.send(())
    }
}
