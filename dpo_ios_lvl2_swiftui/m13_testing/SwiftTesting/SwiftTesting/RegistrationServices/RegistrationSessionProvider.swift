//
//  RegistrationSessionProvider.swift
//  SwiftTesting
//
//  Created by Николай Ногин on 10.12.2022.
//

import Foundation

protocol RegistrationSessionProvider {
    func registerNew(email: String, password: String, repeatPassword: String, completion: @escaping (String?) -> ())
}

final class RegistrationSessionProviderImplementation: RegistrationSessionProvider {
    
    func registerNew(email: String, password: String, repeatPassword: String, completion: (String?) -> ()) {
        if (performCheck(email: email, password: password, repeatPassword: repeatPassword) ) {
            completion("New user has been registered")
        } else {
            completion("Check your credentials")
        }
    }
    
    func performCheck(email: String, password: String, repeatPassword: String) -> Bool {
        let isEmailValid = checkEmail(email: email)
        let isPasswordsValid = checkPasswords(password: password, repeatPassword: repeatPassword)
        return isEmailValid && isPasswordsValid
    }
    
    func checkPasswords(password: String, repeatPassword: String) -> Bool {

        var isContainsSixSymbols = false
        var isContainsOneCapitalLetter = false
        var isContainsOneLowercaseLetter = false
        var isContainsOneNumber = false
        var isNotContainsMarksAndSpaces = false
        var isPasswordsMatch = false
        
        // check if password contains 6 symbols
        if password.count >= 6 {
            isContainsSixSymbols = true
        }
        
        do {
            // check if password contains one Capital letter
            var range = NSRange(password.startIndex..., in: password)
            var regex = try NSRegularExpression(pattern: "[A-Z]+")
            let isContainsCapital = regex.firstMatch(in: password, options: [], range: range)
            if isContainsCapital != nil {
                isContainsOneCapitalLetter = true
            }
            
            // check if password contains one letter
            regex = try NSRegularExpression(pattern: "[a-z]+")
            let isContainsLetter = regex.firstMatch(in: password, options: [], range: range)
            if isContainsLetter != nil {
                isContainsOneLowercaseLetter = true
            }
            
            // check if password contains one number
            regex = try NSRegularExpression(pattern: "[0-9]+")
            let isContainsNumber = regex.firstMatch(in: password, options: [], range: range)
            
            if isContainsNumber != nil {
                isContainsOneNumber = true
            }
            
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
        }
        
        // check that password doesn't contain spaces and punctuation marks
        let unAccesibleCharacters = NSCharacterSet.punctuationCharacters.union(NSCharacterSet.decimalDigits).union(NSCharacterSet.whitespaces)

        if password.rangeOfCharacter(from: unAccesibleCharacters) == nil {
            isNotContainsMarksAndSpaces = true
        }
        
        // check if passwords are equal
        if password == repeatPassword {
            isPasswordsMatch = true
        }
        
        return  isContainsSixSymbols && isContainsOneCapitalLetter && isContainsOneLowercaseLetter && isContainsOneNumber && isNotContainsMarksAndSpaces && isPasswordsMatch
    }
    
    func checkEmail(email: String) -> Bool {
        
        var isNotShort = false
        var isContainsatAtSign = false
        var isHavingADot = false
        var isHavingSymbolsAfterDot = false
            
        // email can't be less than 5 chars: "a@b.r"
        if email.count >= 5 {
            isNotShort = true
            
        }
 
        // check if email contains "@" symbol
        if (email.contains("@")) {
            isContainsatAtSign = true
        }
        // check if email contains a dot "."
        if (email.contains(".")) {
            isHavingADot = true
        }
        
        // check that email has any symbols after dot
        if isNotShort && isHavingADot {
            let components = email.components(separatedBy: ".")
            isHavingSymbolsAfterDot = components[1].count > 0
        }

        return isNotShort && isContainsatAtSign && isHavingADot && isHavingSymbolsAfterDot
    }
}
