//
//  Item3_VC1.swift
//  M13_APP_2
//
//  Created by Николай Ногин on 22.07.2022.
//

import UIKit

class Item3_VC1: UIViewController {
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        addButton()

    }
    
    func addButton() {
        nextButton.setTitle("Next Scene", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)

        
        // Add action to button programmatically
        let action = UIAction(handler: { [weak self] _ in
            self?.navigationController?.pushViewController(Item3_VC2(), animated: true)

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
