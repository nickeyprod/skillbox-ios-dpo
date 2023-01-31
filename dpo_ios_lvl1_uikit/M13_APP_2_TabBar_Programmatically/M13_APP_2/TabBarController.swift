//
//  ViewController.swift
//  M13_APP_2
//
//  Created by Николай Ногин on 21.07.2022.
//

import UIKit

class TabBarController: UITabBarController {
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray3
        
        createTabBar()
    }
    
    private func createTabBar() {
        let item1 = Item1_VC1()
        let item2 = Item2_NC()
        let item3 = Item3_NC()

        let icon1 = UITabBarItem(title: "Item1", image: UIImage(systemName: "pencil.tip"), selectedImage: UIImage(systemName: "pencil.tip"))
        let icon2 = UITabBarItem(title: "Item2", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        let icon3 = UITabBarItem(title: "Item3", image: UIImage(named: "pencil"), selectedImage: UIImage(named: "pencil"))

        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        
        let controllers = [item1, item2, item3]  //array of the root view controllers displayed by the tab bar interface
        
        self.viewControllers = controllers
        self.selectedIndex = 0
    }
}

