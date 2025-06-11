//
//  StartViewController.swift
//  login-assignment
//
//  Created by 박진홍 on 6/11/25.
//

import UIKit
import Combine

final class StartViewController: UIViewController {
    private let viewModel: StartViewModel
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    private var contentView: StartView!
    
    init(viewModel: StartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)는 구현되지 않았습니다.")
    }
    
    override func loadView() {
        contentView = StartView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupViewCallbacks()
    }
    
    private func setupBindings() {
        viewModel.navigateToWelcomePublisher
            .receive(on: DispatchQueue.main) // ViewModel에 @MainActor가 붙어있어 필수코드는 아니지만 메인스레드임을 명시하고 ViewModel의 변경에 대응하지 못하는 일이 없도록
            .sink { [weak self] in
                guard let self = self else { return }
                self.navigateToWelcome()
            }
            .store(in: &cancellables)
        
        viewModel.navigateToSignInPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }
                self.navigateToSignIn()
            }
            .store(in: &cancellables)

    }
    
    private func setupViewCallbacks() {
        contentView.onStartButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.startButtonTapped()
        }
    }
    
    
    // TODO: - View 구현 후 연결
    private func navigateToWelcome() {
        print("WelcomeView로 이동")
        print("[\((#file as NSString).lastPathComponent)] [\(#function): \(#line)] - ")
    }
    
    private func navigateToSignIn() {
        print("SignInView로 이동")
        print("[\((#file as NSString).lastPathComponent)] [\(#function): \(#line)] - ")
    }
}
