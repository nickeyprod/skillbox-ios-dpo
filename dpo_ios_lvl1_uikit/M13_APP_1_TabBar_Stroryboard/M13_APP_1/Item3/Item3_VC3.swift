//
//  Item3_VC3.swift
//  M13_APP_1
//
//  Created by Николай Ногин on 21.07.2022.
//

import UIKit

class Item3_VC3: UIViewController {

    @IBAction func lastButtonPressed(_ sender: Any) {
        let alert = UIAlertController(
            title: "Внимание!",
            message: "Это последний экран!",
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: "Хорошо",
                style: .default,
                handler: nil
            )
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "DISPLAY 3"
    }


}
