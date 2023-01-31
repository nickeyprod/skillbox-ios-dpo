//
//  LoginSessionProviderMock.swift
//  SwiftTestingTests
//
//  Created by Николай Ногин on 10.12.2022.
//

import Foundation
@testable import SwiftTesting

class LoginSessionProviderMock: LoginSessionProvider {
    var on_get: ((_ user: String, _ password: String, _ completion: (String?) -> Void) -> Void )?
    
    func get(email: String, password: String, completion: @escaping (String?) -> ()) {
        on_get?(email, password, completion)
    }
}
