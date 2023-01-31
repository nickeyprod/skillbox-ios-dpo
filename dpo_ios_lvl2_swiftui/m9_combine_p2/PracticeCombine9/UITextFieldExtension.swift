//
//  UITextFieldExtension.swift
//  PracticeCombine9
//
//  Created by Николай Ногин on 02.12.2022.
//

import Foundation
import UIKit
import Combine


extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UITextField }
            .compactMap{
                return $0.text
            }
            .eraseToAnyPublisher()
    }
}
