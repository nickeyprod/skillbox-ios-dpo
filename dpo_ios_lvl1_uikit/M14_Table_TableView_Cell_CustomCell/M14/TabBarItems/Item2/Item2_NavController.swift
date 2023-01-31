//
//  Item2_NavController.swift
//  M14
//
//  Created by Николай Ногин on 25.07.2022.
//

import UIKit

// Вкладка 2 - Задание 2

class Item2_NavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pushViewController(Item2_ViewController(), animated: true)
        
    }
}

