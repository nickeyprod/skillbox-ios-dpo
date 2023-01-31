//
//  Item3_NC.swift
//  M13_APP_2
//
//  Created by Николай Ногин on 22.07.2022.
//

import UIKit

class Item3_NC: UINavigationController {
    
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemYellow
        self.pushViewController(Item3_VC1(), animated: true)
    }
    
}


