//
//  SignUpViewModel.swift
//  login-assignment
//
//  Created by 박진홍 on 6/13/25.
//

import Combine

@MainActor
final class SignUpViewModel {
    private let signUpUseCase: SignUpUseCase
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var nickname: String = ""
    @Published private(set) var isLoading: Bool = false
    
    private let signUpButtonSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    private let signUpResultSubject: PassthroughSubject<Result<Void, Error>, Never> = PassthroughSubject<Result<Void, Error>, Never>()
    private let navigateToSignInSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    var signUpButtonPublisher: AnyPublisher<Void, Never> {
        signUpButtonSubject.eraseToAnyPublisher()
    }
    var signUpResultPublisher: AnyPublisher<Result<Void, Error>, Never> {
        signUpResultSubject.eraseToAnyPublisher()
    }
    var isSignUpButtonEnabled: AnyPublisher<Bool, Never> {
        let isFilled = Publishers.CombineLatest4($email, $password, $confirmPassword, $nickname)
            .map { email, password, confirmPassword, nickname in
                !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                && !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                && !confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                && (password == confirmPassword)
                && !nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            }
        return Publishers.CombineLatest(isFilled, $isLoading)
            .map { isFilled, isLoading in
                isFilled && !isLoading
            }
            .eraseToAnyPublisher()
    }
    var navigateToSignInPublisher: AnyPublisher<Void, Never> {
        navigateToSignInSubject.eraseToAnyPublisher()
    }
    
    init(useCase: SignUpUseCase) {
        self.signUpUseCase = useCase
        bind()
    }
    
    func signUpButtonTapped() {
        signUpButtonSubject.send(())
    }
    
    func signInButtonTapped() {
        navigateToSignInSubject.send(())
    }
    
    private func bind() {
        signUpButtonSubject
            .filter { [weak self] in
                guard let self = self else { return false }
                return !self.isLoading
            }
            .sink { [weak self] in
                self?.signUp()
            }
            .store(in: &cancellables)
    }
    
    private func signUp() {
        isLoading = true
        
        Task {
            defer { self.isLoading = false}
            do {
                let signUpDto: SignUpDto = SignUpDto(email: email, password: password, nickname: nickname)
                try await signUpUseCase.execute(user: signUpDto)
                signUpResultSubject.send(.success(()))
            } catch {
                signUpResultSubject.send(.failure(error))
            }
        }
    }
    
}
