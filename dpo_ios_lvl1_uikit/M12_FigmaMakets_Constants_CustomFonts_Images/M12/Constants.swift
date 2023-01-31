//
//  Constants.swift
//  M12
//
//  Created by Николай Ногин on 18.07.2022.
//

import UIKit

enum Constants {
    enum Colors {
        static var color01: UIColor? {
            UIColor(named: "01")
        }
        
        static var color02: UIColor? {
            UIColor(named: "02")
        }
        
        static var color03: UIColor? {
            UIColor(named: "03")
        }
        
        static var color04: UIColor? {
            UIColor(named: "04")
        }
    }
    
    enum Fonts  {
        static var ui10Regular: UIFont? {
            UIFont(name: "Inter-Regular", size: 10)
        }
        
        static var ui14Semi: UIFont? {
            UIFont(name: "Inter-SemiBold", size: 14)
        }
        
        static var systemHeading: UIFont {
            UIFont.systemFont(ofSize: 39, weight: .bold)
        }
        
        static var systemText: UIFont {
            UIFont.systemFont(ofSize: 14, weight: .light)
        }
    }
    
    enum Images {
        static let star = UIImage(named: "Star")
    }
    
    enum Texts {
        static let header = Bundle.main.localizedString(forKey: "Header", value: "", table: "Localization")
        static let firstText = Bundle.main.localizedString(forKey: "First Text", value: "", table: "Localization")
        static let secondText = Bundle.main.localizedString(forKey: "Second Text", value: "", table: "Localization")
    }
}
