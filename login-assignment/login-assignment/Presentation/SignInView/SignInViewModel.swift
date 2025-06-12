//
//  SignInViewModel.swift
//  login-assignment
//
//  Created by 박진홍 on 6/12/25.
//

import Combine

@MainActor
final class SignInViewModel {
    private let signInUseCase: SignInUseCase
    private var cancellables: Set<AnyCancellable> = []

    @Published var email: String = ""
    @Published var password: String = ""
    @Published private(set) var isLoading: Bool = false

    private let signInButtonSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    private let signInResultSubject: PassthroughSubject<Result<Void, Error>, Never> = {
        PassthroughSubject<Result<Void, Error>, Never>()
    }()
    private let navigateToSignUpSubject: PassthroughSubject<Void, Never> = {
        PassthroughSubject<Void, Never>()
    }()

    var signInButtonPublisher: AnyPublisher<Void, Never> {
        signInButtonSubject.eraseToAnyPublisher()
    }
    var signInResultPublisher: AnyPublisher<Result<Void, Error>, Never> {
        signInResultSubject.eraseToAnyPublisher()
    }
    var isSignInButtonEnabled: AnyPublisher<Bool, Never> {
        let isFilled = Publishers.CombineLatest($email, $password)
            .map { email, password in
                !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                && !password.isEmpty
            }

        return Publishers.CombineLatest(isFilled, $isLoading)
            .map { isFilled, isLoading in
                isFilled && !isLoading
            }
            .eraseToAnyPublisher()
    }
    var navigateSignUpPublisher: AnyPublisher<Void, Never> {
        navigateToSignUpSubject.eraseToAnyPublisher()
    }

    init(useCase: SignInUseCase) {
        self.signInUseCase = useCase
        bind()
    }

    func signInButtonTapped() {
        signInButtonSubject.send(())
    }
    func signUpButtonTapped() {
        navigateToSignUpSubject.send(())
    }

    private func bind() {
        signInButtonSubject
            .filter { [weak self] in
                guard let self = self else { return false }
                return !self.isLoading
            }
            .sink { [weak self] in
                self?.signIn()
            }
            .store(in: &cancellables)
    }

    private func signIn() {
        isLoading = true
        Task {
            defer { self.isLoading = false }
            do {
                try await signInUseCase.execute(email: email, password: password)
                signInResultSubject.send(.success(()))
            } catch {
                signInResultSubject.send(.failure(error))
            }
        }

    }
}
