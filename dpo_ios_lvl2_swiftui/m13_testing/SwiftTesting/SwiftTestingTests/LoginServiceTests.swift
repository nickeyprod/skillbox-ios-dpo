//
//  LoginServiceTests.swift
//  SwiftTestingTests
//
//  Created by Николай Ногин on 10.12.2022.
//

import Foundation
import XCTest
@testable import SwiftTesting

final class LoginServiceTests: XCTestCase {
    var sessionProvider: LoginSessionProviderMock!
    var loginService: LoginService!

    override func setUpWithError() throws {
        sessionProvider = LoginSessionProviderMock()
        loginService = LoginService(sessionProvider: sessionProvider)
    }

    override func tearDownWithError() throws {
        sessionProvider = nil
        loginService = nil
    }
    
    func test_login_withCallProvider_shouldPassRightParams() {
        // Given
        let exp = expectation(description: "wait for a session")
        
        sessionProvider.on_get = { email, password, completion in
            XCTAssertEqual(email, "user")
            XCTAssertEqual(password, "pwrd777")
            exp.fulfill()
        }
        
        // When
        loginService.login(
            email: "user",
            password: "pwrd777",
            completion: { _ in }
        )
        
        // Then
        waitForExpectations(timeout: 1)
        
    }
    
    func test_login_withCallProvider_shouldGetRightSession() {
        // Given
        let exp = expectation(description: "wait for a session")
        
        sessionProvider.on_get = { user, password, completion in
            completion("Logged IN!")
        }
        
        // When
        loginService.login(
            email: "user",
            password: "pwrd777",
            completion: { session in
                XCTAssertEqual(session, "Logged IN!")
                exp.fulfill()
            }
        )
        
        // Then
        waitForExpectations(timeout: 1)
    }

}
