//
//  Item3_NavController.swift
//  M14
//
//  Created by Николай Ногин on 25.07.2022.
//

import UIKit

// Вкладка 3 - Задание 3

class Item3_NavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pushViewController(Item3_ViewController(), animated: true)
        
    }
}

