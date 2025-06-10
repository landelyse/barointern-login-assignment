//
//  LengthContraints.swift
//  login-assignment
//
//  Created by 박진홍 on 6/10/25.
//

import Foundation

struct EmailRule {
    static func validate(_ input: String) -> Bool {
        guard ValidationHelper.isEmail(text: input) else {
            return false
        }
        guard let localPart: String = input.components(separatedBy: "@").first,
              ValidationHelper.isValidLength(text: localPart, min: 6, max: 20) else {
            return false
        }
        guard ValidationHelper.isStartWithLetter(text: localPart) else {
            return false
        }
        return true
    }
}

struct PasswordRule {
    static func validate(_ input: String) -> Bool {
        guard ValidationHelper.isValidLength(text: input, min: 8, max: 20) else {
            return false
        }
        guard ValidationHelper.hasLetter(text: input) else {
            return false
        }
        guard ValidationHelper.hasNumber(text: input) else {
            return false
        }
        guard ValidationHelper.hasSpecialCharacter(text: input) else {
            return false
        }
        return true
    }
}

struct NicknameRule {
    static func validate(_ input: String) -> Bool {
        guard ValidationHelper.isValidLength(text: input, min: 2, max: 20) else {
            return false
        }
        return true
    }
}

private enum ValidationHelper {
    static func hasLetter(text: String) -> Bool {
        let regex: Regex<Substring> = try! Regex(#"[A-Za-z]"#)
        return text.contains(regex)
    }
    
    static func hasNumber(text: String) -> Bool {
        let regex: Regex<Substring> = try! Regex(#"[\d]"#)
        return text.contains(regex)
    }
    
    static func hasSpecialCharacter(text: String) -> Bool {
        let regex: Regex<Substring> = try! Regex(#"[!@#$%^&*()_+-=,./<>|\?;':"]"#)
        return text.contains(regex)
    }
    
    static func isEmail(text: String) -> Bool {
        let emailPattern: String = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#
        let predicate: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        
        guard predicate.evaluate(with: text) else {
            return false
        }
        
        return true
    }
    
    static func isValidLength(text: String, min: Int, max: Int) -> Bool {
        return (min...max).contains(text.count)
    }
    
    static func isStartWithLetter(text: String) -> Bool {
        guard let firstCharacter: Character = text.first else {
            return false
        }
        return firstCharacter.isLetter
    }
}
