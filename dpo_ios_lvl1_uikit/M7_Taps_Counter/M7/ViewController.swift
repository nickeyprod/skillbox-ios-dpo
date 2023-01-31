//
//  ViewController.swift
//  M7
//
//  Created by Николай Ногин on 06.07.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var pressedNum = 0
    
    @IBOutlet weak var pressedNumLabel: UILabel!
    
    @IBAction func buttonPressed(_ sender: Any) {
        pressedNum += 1
        pressedNumLabel.text = "Нажатий: \(pressedNum)"
    }
}

