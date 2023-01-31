//
//  NavigationController.swift
//  MVP_Project
//
//  Created by Николай Ногин on 05.09.2022.
//

import UIKit
//import SnapKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.pushViewController(TableViewController(), animated: true)
    }
}
