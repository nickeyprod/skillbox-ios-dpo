//
//  Item1_VC1.swift
//  M13_APP_2
//
//  Created by Николай Ногин on 22.07.2022.
//

import UIKit

class Item1_VC1: UIViewController {
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        addButton()
    }
    
    func addButton() {
        nextButton.setTitle("Next Scene", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        
        // Add action to button programmatically
        let action = UIAction(handler: { [weak self] _ in
            let alert = UIAlertController(
                title: "Внимание!",
                message: "Это последний экран!",
                preferredStyle: .alert
            )
            
            alert.addAction(
                UIAlertAction(
                    title: "Хорошо",
                    style: .default,
                    handler: nil
                )
            )
            self?.present(alert, animated: true, completion: nil)
        })

        nextButton.addAction(action, for: .touchUpInside)
        
        self.view.addSubview(nextButton)
        
        addConstraintsToButton()
    }
    
    func addConstraintsToButton() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
