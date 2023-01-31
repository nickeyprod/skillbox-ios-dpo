//
//  RegistrationViewController.swift
//  SwiftTesting
//
//  Created by Николай Ногин on 10.12.2022.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController {
    
    var registrationProvider: RegistrationSessionProvider? = nil
    var registrationService: RegistrationService? = nil
    
    @IBOutlet weak var userEmailInpt: UITextField!
    @IBOutlet weak var userPasswordInpt: UITextField!
    @IBOutlet weak var repeatPasswordInpt: UITextField!
    
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        if let userEmail = userEmailInpt.text, let userPassword = userPasswordInpt.text, let repeatPassword = repeatPasswordInpt.text {
            register(email: userEmail, password: userPassword, repeatPassword: repeatPassword)
        }

    }
    
    var sessionProvider: RegistrationSessionProvider? = nil
    var loginService: RegistrationService? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sessionProvider = RegistrationSessionProviderImplementation()
        registrationService = RegistrationService(sessionProvider: sessionProvider!)
        
        userEmailInpt.accessibilityIdentifier = "regEmailTextFieldInpt"
        userPasswordInpt.accessibilityIdentifier = "regPasswordTextFieldInpt"
        repeatPasswordInpt.accessibilityIdentifier = "regRepeatPasswordTextFieldInpt"
    }
    
    func register(email: String, password: String, repeatPassword: String) {
        
        registrationService?.registerNew(email: email, password: password, repeatPassword: repeatPassword, completion: { session in
            print(session as Any)
        })
        
    }
}
