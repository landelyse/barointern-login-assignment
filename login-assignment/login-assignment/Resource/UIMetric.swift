//
//  UIMetric.swift
//  login-assignment
//
//  Created by 박진홍 on 6/11/25.
//

import Foundation

enum UIMetric {
    enum Padding {
        static let small: CGFloat = 8
        static let regular: CGFloat = 16
        static let large: CGFloat = 24
    }
    
    enum CornerRadius {
        static let button: CGFloat = 50
        static let textField: CGFloat = 15
    }
    
    enum FontSize {
        static let title: CGFloat = 28
        static let title2: CGFloat = 24
        static let subTitle: CGFloat = 20
        static let body: CGFloat = 16
        static let caption: CGFloat = 12
    }
    
    enum ViewHeight {
        static let boxHeight: CGFloat = 250
        static let buttonHeight: CGFloat = 150
    }
}
