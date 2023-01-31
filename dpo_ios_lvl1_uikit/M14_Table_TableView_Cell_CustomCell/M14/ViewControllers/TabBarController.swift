//
//  ViewController.swift
//  M14
//
//  Created by Николай Ногин on 25.07.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        createTabBar()
        
    }
    
    private func createTabBar() {
        let item1 = Item1_NavController()
        let item2 = Item2_NavController()
        let item3 = Item3_NavController()

        let icon1 = UITabBarItem(title: "Задание 1", image: UIImage(systemName: "book"), selectedImage: UIImage(systemName: "book"))
        let icon2 = UITabBarItem(title: "Задание 2", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house"))
        let icon3 = UITabBarItem(title: "Задание 3", image: UIImage(systemName: "briefcase.fill"), selectedImage: UIImage(systemName: "briefcase.fill"))
        
        item1.tabBarItem = icon1
        item2.tabBarItem = icon2
        item3.tabBarItem = icon3
        
        let controllers = [item1, item2, item3]  //array of the root view controllers displayed by the tab bar interface

        self.viewControllers = controllers
        self.selectedIndex = 2
    }

}

