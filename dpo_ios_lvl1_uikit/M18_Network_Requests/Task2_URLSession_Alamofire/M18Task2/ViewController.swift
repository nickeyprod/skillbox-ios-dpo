//
//  ViewController.swift
//  M19
//
//  Created by Николай Ногин on 17.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let webService = WebService()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var occupationTextField: UITextField!
    
    @IBAction func onURLSessionClick(_ sender: Any) {
        sendDataWith(anURLSession: true)
    }
    
    @IBAction func onAlamofireClick(_ sender: Any) {
        sendDataWith(anAlamofire: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    public func sendDataWith(anAlamofire: Bool = false, anURLSession: Bool = false) {
        guard let userProfileData = collectData() else {return}
        
        if (anAlamofire) {
            webService.sendDataWithAlamofire(data: userProfileData) { [weak self] (message, error) in
                guard let self = self else { return }
                guard error == nil else {
                    return self.showErrorAlert(message: error!)
                }
                self.showSuccessAlert(message: message)
            }
        } else if (anURLSession) {
            webService.sendDataWithURLSession(data: userProfileData) { [weak self] (message, error) in
                guard let self = self else { return }
                guard error == nil else {
                    return self.showErrorAlert(message: error!)
                }
                self.showSuccessAlert(message: message)
            }
        }
    }
    
    func collectData() -> UserProfile? {
        guard let name = nameTextField.text,
              let lastName = lastNameTextField.text,
              let birth = birthTextField.text,
              let country = countryTextField.text,
              let occupation = occupationTextField.text else {return nil}
       
        let userProfile = UserProfile(id: 0, birth: Int(birth) ?? 0, occupation: occupation, name: name, lastname: lastName, country: country)
        return userProfile
    }
    
    func showSuccessAlert(message: (Int?, String?) = (0, "No Url")) {
        let alert = UIAlertController(
            title: "Success!",
            message: "Object Created With ID: \(message.0!). And you can find it with this URL: \(message.1!)",
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert(message: String = "Unknown error") {
        print("========= ERROR OCCURED =========")
        print(message)
        
        let alert = UIAlertController(
            title: "Error!",
            message: "\(message)",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        self.present(alert, animated: true, completion: nil)
    }


}

