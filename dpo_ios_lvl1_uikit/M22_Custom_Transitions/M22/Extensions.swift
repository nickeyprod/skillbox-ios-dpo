//
//  Extensions.swift
//  M22
//
//  Created by Николай Ногин on 09.09.2022.
//
import UIKit

extension UIViewController {
    func addStackView(vStack: UIStackView) {
        vStack.axis = .vertical
        vStack.spacing = 8.0
        vStack.frame =  CGRect(x: 0, y: 0, width: 300, height: 350)
        vStack.distribution  = .equalCentering
        vStack.alignment = .fill
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)
        vStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension UIButton {
    convenience init(title: String, target: Any, selector: Selector) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        addTarget(target, action: selector, for: .touchUpInside)
    }
}
