//
//  Constants.swift
//  M15
//
//  Created by Николай Ногин on 02.08.2022.
//

import UIKit

enum Constants {
    enum Fonts {
        static let interSemiBold = "Inter-SemiBold"
        static let interRegular = "Inter-Regular"
    }
    enum Text {
        static let mainHeader = "Header"
        static let secondaryText = "He'll want to use your yacht, and I don't want this thing smelling like fish."
        static let time = "8m ago"
    }
    enum Images {
        static let mainImage = UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal)
    }
    enum Colors {
        static let timeColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        static let headerColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        static let textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
