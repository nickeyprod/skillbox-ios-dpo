//
//  RegistrationService.swift
//  SwiftTesting
//
//  Created by Николай Ногин on 10.12.2022.
//

import Foundation

final class RegistrationService {
    private let sessionProvider: RegistrationSessionProvider
    
    init(sessionProvider: RegistrationSessionProvider = RegistrationSessionProviderImplementation()) {
        self.sessionProvider = sessionProvider
    }
    
    func registerNew(email: String, password: String, repeatPassword: String, completion: @escaping (String?) -> ()) {
        sessionProvider.registerNew(email: email, password: password, repeatPassword: repeatPassword, completion: completion)
    }
}
