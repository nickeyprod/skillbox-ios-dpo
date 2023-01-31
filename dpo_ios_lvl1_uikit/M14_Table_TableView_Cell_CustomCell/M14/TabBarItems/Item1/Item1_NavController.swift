//
//  Item1_NavController.swift
//  M14
//
//  Created by Николай Ногин on 25.07.2022.
//

import UIKit

// Вкладка 1 - Задание 1

class Item1_NavController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pushViewController(Item1_ViewController(), animated: true)
        
    }
}
