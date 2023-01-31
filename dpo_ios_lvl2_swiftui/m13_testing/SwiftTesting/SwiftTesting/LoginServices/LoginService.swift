//
//  LoginService.swift
//  SwiftTesting
//
//  Created by Николай Ногин on 10.12.2022.
//

import Foundation

final class LoginService {
    private let sessionProvider: LoginSessionProvider
    
    init(sessionProvider: LoginSessionProvider = LoginSessionProviderImplementation()) {
        self.sessionProvider = sessionProvider
    }
    
    func login(email: String, password: String, completion: @escaping (String?) -> ()) {
        sessionProvider.get(email: email, password: password, completion: completion)
    }
}
