//
//  Item2NC.swift
//  M13_APP_1
//
//  Created by Николай Ногин on 21.07.2022.
//

import UIKit

class Item2_NC: UINavigationController {
    
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemYellow
        self.pushViewController(Item2_VC1(), animated: true)
    }
    
}

