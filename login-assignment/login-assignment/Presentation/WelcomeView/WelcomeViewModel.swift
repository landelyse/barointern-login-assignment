//
//  WelcomeViewModel.swift
//  login-assignment
//
//  Created by 박진홍 on 6/13/25.
//

import Combine

@MainActor
final class WelcomeViewModel {
    private let signOutUseCase: SignOutUseCase
    private let deleteUserUseCase: DeleteUserUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    private let signOutSubject: PassthroughSubject<Void, Never> = {
        PassthroughSubject<Void, Never>()
    }()
    private let deleteUserSubject: PassthroughSubject<Void, Never> = {
        PassthroughSubject<Void, Never>()
    }()
    private let deleteUserResultSubject: PassthroughSubject<Result<Void, Error>, Never> = {
        PassthroughSubject<Result<Void, Error>, Never>()
    }()
    
    
    var signOutPublisher: AnyPublisher<Void, Never> {
        signOutSubject.eraseToAnyPublisher()
    }
    var deleteUserResultPublisher: AnyPublisher<Result<Void, Error>, Never> {
        deleteUserResultSubject.eraseToAnyPublisher()
    }
    var deleteUserPublisher: AnyPublisher<Void, Never> {
        deleteUserSubject.eraseToAnyPublisher()
    }
    
    init(signOutUseCase: SignOutUseCase,
         deleteUserUseCase: DeleteUserUseCase
    ) {
        self.signOutUseCase = signOutUseCase
        self.deleteUserUseCase = deleteUserUseCase
        bind()
    }
    
    func signOutButtonTapped() {
        signOutSubject.send()
    }
    
    func deleteButtonTapped() {
        deleteUserSubject.send()
    }
    
    private func bind() {
        signOutSubject
            .sink {  [weak self] in
                self?.signOut()
            }
            .store(in: &cancellables)
        
        deleteUserSubject
            .sink  {  [weak self] in
                self?.deleteUser()
            }
            .store(in: &cancellables)
    }
    
    private func deleteUser() {
        Task {
            do {
                try await deleteUserUseCase.execute()
                deleteUserResultSubject.send(.success(()))
            } catch {
                deleteUserResultSubject.send(.failure(error))
            }
        }
    }
    
    private func signOut() {
        signOutUseCase.execute()
    }
}
