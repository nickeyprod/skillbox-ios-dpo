//
//  ViewController.swift
//  SwiftTesting
//
//  Created by Николай Ногин on 10.12.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    var sessionProvider: LoginSessionProvider? = nil
    var loginService: LoginService? = nil

    @IBOutlet weak var userEmailInpt: UITextField!
    @IBOutlet weak var userPasswordInpt: UITextField!
    
    
    @IBAction func logInButtonPressed(_ sender: Any) {
        if let userEmail = userEmailInpt.text, let userPassword = userPasswordInpt.text {
            print(userEmail, userPassword)
            logIn(email: userEmail , password: userPassword)
        } else {
            print("No user name or password")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sessionProvider = LoginSessionProviderImplementation()
        loginService = LoginService(sessionProvider: sessionProvider!)
    }
    
    func logIn(email: String, password: String) {
        loginService!.login(
            email: email,
            password: password,
            completion: { session in
                print(session as Any)
            }
        )
    }
}


class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
    }
}
