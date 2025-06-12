//
//  WelcomeViewController.swift
//  login-assignment
//
//  Created by 박진홍 on 6/13/25.
//

import UIKit
import Combine

final class WelcomeViewController: UIViewController {
    private var contentView: WelcomeUIView!
    var cancellables: Set<AnyCancellable> = []
    private let viewModel: WelcomeViewModel
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder) 미구현")
    }
    
    override func loadView() {
        contentView = WelcomeUIView()
        view = contentView
    }
    
    override func viewDidLoad() {
        setupViewCallbacks()
    }
    
    private func setupViewCallbacks() {
        contentView.onSignOutButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.signOutButtonTapped()
        }
        contentView.onDeleteButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.deleteButtonTapped()
        }
    }
}
