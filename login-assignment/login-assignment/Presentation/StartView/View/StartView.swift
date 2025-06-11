//
//  StartView.swift
//  login-assignment
//
//  Created by 박진홍 on 6/11/25.
//

import UIKit

final class StartView: UIView {
    var onStartButtonTapped: (() -> Void)?
    
    private let coloredBox: UIView = {
        let box = UIView()
        box.backgroundColor = .boxColor
        return box
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to the App"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIMetric.FontSize.title)
        label.textColor = .black
        return label
    }()
    
    private let descriptionText: UILabel = {
        let label = UILabel()
        label.text = "바로인턴에 바로 로그인해보세요!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: UIMetric.FontSize.body)
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Start", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: UIMetric.FontSize.body)
        button.backgroundColor = .buttonColor
        button.layer.cornerRadius = UIMetric.CornerRadius.button
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:)는 구현되지 않았습니다.")
    }
    
    private func setupUI() {
        backgroundColor = .white
        [
            coloredBox,
            titleLabel,
            descriptionText,
            startButton
        ].forEach { view in
            addSubview(view)
        }
    }
    
    private func setupConstraints() {
        [
            coloredBox,
            titleLabel,
            descriptionText,
            startButton
        ].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            coloredBox.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            coloredBox.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            coloredBox.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            coloredBox.heightAnchor.constraint(equalToConstant: UIMetric.ViewHeight.boxHeight),
            
            titleLabel.topAnchor.constraint(equalTo: coloredBox.bottomAnchor, constant: UIMetric.Padding.large),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIMetric.Padding.large),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIMetric.Padding.large),
            
            descriptionText.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIMetric.Padding.regular),
            descriptionText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIMetric.Padding.large),
            descriptionText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIMetric.Padding.large),
            
            startButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -UIMetric.Padding.large),
            startButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIMetric.Padding.large),
            startButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIMetric.Padding.large),
            startButton.heightAnchor.constraint(equalToConstant: UIMetric.ViewHeight.buttonHeight)
        ])
    }
    
    private func setupButtonAction() {
        let action: UIAction = UIAction { [weak self] _ in
            self?.onStartButtonTapped?()
        }
        startButton.addAction(action, for: .touchUpInside)
    }
}
