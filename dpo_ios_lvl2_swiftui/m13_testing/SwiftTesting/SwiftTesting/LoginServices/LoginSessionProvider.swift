//
//  LoginSessionProvider.swift
//  SwiftTesting
//
//  Created by Николай Ногин on 10.12.2022.
//

import Foundation

protocol LoginSessionProvider {
    func get(email: String, password: String, completion: @escaping (String?) -> ())
}

final class LoginSessionProviderImplementation: LoginSessionProvider {
    func get(email: String, password: String, completion: (String?) -> ()) {
        let userEmail: String = "user@ya.ru"
        let userPassword: String = "pwrd777"
        if (email == userEmail && password == userPassword) {
            completion("Logged IN!")
        } else {
            completion("No such user, or wrong password")
        }
        
    }
}
