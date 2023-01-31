//
//  ViewController.swift
//  M12
//
//  Created by Николай Ногин on 17.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Views
        
    private lazy var imageStar: UIImageView = {
        let imageStar = UIImageView()
        imageStar.widthAnchor.constraint(equalToConstant: 110).isActive = true
        imageStar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageStar.image = Constants.Images.star
        return imageStar
    }()
    
    
    private lazy var label1: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.header
        label.textColor = Constants.Colors.color04
        label.font = Constants.Fonts.systemHeading
        return label
    }()
    
    private lazy var label2: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.firstText
        label.textColor = Constants.Colors.color03
        label.font = Constants.Fonts.ui10Regular
        return label
    }()
    
    private lazy var label3: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.secondText
        label.textColor = Constants.Colors.color02
        label.font = Constants.Fonts.ui14Semi
        return label
    }()
    
    
    private lazy var label4: UILabel = {
        let label = UILabel()
        let helloStr = "Hello, people there!"
        
        let attrStr = NSMutableAttributedString(string: helloStr)

        if let commaIndex = helloStr.firstIndex(of: ",") {
            let strRange = NSRange(helloStr.startIndex ..< commaIndex, in: helloStr)
            attrStr.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: strRange)
            let strRange2 = NSRange(commaIndex ..< helloStr.endIndex, in: helloStr)
            attrStr.addAttribute(.foregroundColor, value: UIColor.systemGreen, range: strRange2)
        }
        
        label.attributedText = attrStr
        return label
    }()
    
    
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.addArrangedSubview(imageStar)
        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(label2)
        stackView.addArrangedSubview(label3)
        stackView.addArrangedSubview(label4)
        return stackView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Private
    private func setupViews() {
        view.addSubview(stackView)
    }
    
    private func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }


}

