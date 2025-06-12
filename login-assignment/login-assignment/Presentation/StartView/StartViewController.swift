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
    var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    private var contentView: StartUIView!

    init(viewModel: StartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:)는 구현되지 않았습니다.")
    }

    override func loadView() {
        contentView = StartUIView()
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewCallbacks()
    }

    private func setupViewCallbacks() {
        contentView.onStartButtonTapped = { [weak self] in
            guard let self = self else { return }
            self.viewModel.startButtonTapped()
        }
    }
}
