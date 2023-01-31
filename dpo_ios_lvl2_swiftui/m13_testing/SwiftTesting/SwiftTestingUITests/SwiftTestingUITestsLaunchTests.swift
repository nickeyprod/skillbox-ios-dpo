//
//  SwiftTestingUITestsLaunchTests.swift
//  SwiftTestingUITests
//
//  Created by Николай Ногин on 10.12.2022.
//

import XCTest

final class SwiftTestingUITestsLaunchTests: XCTestCase {
    var app: XCUIApplication!
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }
    
    // Function to check if email is valid email adress
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
    
    // Testing if email is valid
    func testEmailValid() throws {
        // Given
        let emailInpt = app.textFields["regEmailTextFieldInpt"]
        
        // When
        emailInpt.tap()
        emailInpt.typeText("go@ya.ru")
        
        let emailInptText = emailInpt.value as! String
        let emailIsValid = checkEmail(email: emailInptText)
        
        // Then
        XCTAssertEqual(emailIsValid, true);
        
    }
    
    // Testing if password not less than 6 symbols
    func testPasswordNotLessThanSixSymbols() {
        // Given
        let passwordInpt = app.textFields["regPasswordTextFieldInpt"]
        
        // When
        passwordInpt.tap()
        passwordInpt.typeText("Xc6jcff43")
        
        var isContainsSixSymbols = false
        let passwordInptText = passwordInpt.value as! String
        if passwordInptText.count >= 6 {
            isContainsSixSymbols = true
        }
        
        // Then
        XCTAssertEqual(isContainsSixSymbols, true)
        
    }
    
    // Testing if password has any capital letters
    func testPasswordContainsAnyCapitalLetter() {
        // Given
        let passwordInpt = app.textFields["regPasswordTextFieldInpt"]
        
        // When
        passwordInpt.tap()
        passwordInpt.typeText("Xc6jcff43")
        
        var isContainsAnyCapitalLetter = false
        let passwordInptText = passwordInpt.value as! String
        
        // check if password contains one Capital letter
        let range = NSRange(passwordInptText.startIndex..., in: passwordInptText)
        let regex = try! NSRegularExpression(pattern: "[A-Z]+")
        let isContainsCapital = regex.firstMatch(in: passwordInptText, options: [], range: range)
        if isContainsCapital != nil {
            isContainsAnyCapitalLetter = true
        }
        
        // Then
        XCTAssertEqual(isContainsAnyCapitalLetter, true)
        
    }
    
    // Testing if password has any usual letter
    func testPasswordContainsAnyLetter() {
        // Given
        let passwordInpt = app.textFields["regPasswordTextFieldInpt"]
        
        // When
        passwordInpt.tap()
        passwordInpt.typeText("Xc6jcff43")
        
        var isContainsAnyLetter = false
        let passwordInptText = passwordInpt.value as! String
        
        // check if password contains any usual letter
        let range = NSRange(passwordInptText.startIndex..., in: passwordInptText)
        let regex = try! NSRegularExpression(pattern: "[a-z]+")
        let isContainsLetter = regex.firstMatch(in: passwordInptText, options: [], range: range)
        if isContainsLetter != nil {
            isContainsAnyLetter = true
        }
        
        // Then
        XCTAssertEqual(isContainsAnyLetter, true)
    }
    
    // Testing if password contains any number
    func testPasswordContainsAnyNumber() {
        // Given
        let passwordInpt = app.textFields["regPasswordTextFieldInpt"]
        
        // When
        passwordInpt.tap()
        passwordInpt.typeText("Xc6jcff43")
        
        var isContainsAnyNumber = false
        let passwordInptText = passwordInpt.value as! String
        
        // check if password contains any number
        let range = NSRange(passwordInptText.startIndex..., in: passwordInptText)
        let regex = try! NSRegularExpression(pattern: "[0-9]+")
        let isContainsNumber = regex.firstMatch(in: passwordInptText, options: [], range: range)
        if isContainsNumber != nil {
            isContainsAnyNumber = true
        }
        
        // Then
        XCTAssertEqual(isContainsAnyNumber, true)
    }
    
    // Testing if password does not have any spaces and special characters
    func testPasswordNotContainsSpacesAndSpecialChars() {
        
        // Given
        let passwordInpt = app.textFields["regPasswordTextFieldInpt"]
        
        // When
        passwordInpt.tap()
        passwordInpt.typeText("Xc6jcff43")
        
        var isNotContainsMarksAndSpaces = false
        let passwordInptText = passwordInpt.value as! String
        
        // check that password doesn't contain spaces and punctuation marks
        let unAccesibleCharacters = NSCharacterSet.punctuationCharacters.union(NSCharacterSet.whitespaces)
        if passwordInptText.rangeOfCharacter(from: unAccesibleCharacters) == nil {
            isNotContainsMarksAndSpaces = true
        }
        
        // Then
        XCTAssertEqual(isNotContainsMarksAndSpaces, true)
    }
    
    // Testing if passwords are equall
    func testPasswordsAreEqual() {
    
        // Given
        let passwordInpt = app.textFields["regPasswordTextFieldInpt"]
        let repeatPasswordInpt = app.textFields["regRepeatPasswordTextFieldInpt"]
        
        // When
        passwordInpt.tap()
        passwordInpt.typeText("Xc6jcff43")
        repeatPasswordInpt.tap()
        repeatPasswordInpt.typeText("Xc6jcff43")
     
        let passwordInptText = passwordInpt.value as! String
        let passwordRepeatInptText = repeatPasswordInpt.value as! String
            
        // Then
        XCTAssertEqual(passwordInptText, passwordRepeatInptText)
    }
}
