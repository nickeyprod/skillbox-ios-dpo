//
//  CustomCell.swift
//  M15
//
//  Created by Николай Ногин on 02.08.2022.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    
    private lazy var mainHorizontalStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.contentMode = .scaleAspectFit
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var img: UIImageView = {
        let img = UIImageView()
        img.image = Constants.Images.mainImage
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .systemGray4
        img.layer.cornerRadius = 8
        
        return img
    }()
    
    private lazy var horizontalUpperStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.contentMode = .scaleToFill
        return stackView
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .firstBaseline
        return stackView
    }()
    
    private lazy var labelHeader: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.mainHeader
        label.textColor = Constants.Colors.headerColor
        label.font = UIFont(name: Constants.Fonts.interSemiBold, size: 16)
        return label
    }()
    
    private lazy var secondaryText: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.secondaryText
        label.textColor = Constants.Colors.textColor
        label.font = UIFont(name: Constants.Fonts.interRegular, size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var time: UILabel = {
        let label = UILabel()
        label.text = Constants.Text.time
        label.font = UIFont(name: Constants.Fonts.interRegular, size: 14)
        label.textColor = Constants.Colors.timeColor
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addMainHorizontalStack()
        addImageToMainHorizontalStack()

        addVerticalStackToMainHorizontalStack()
        addHorizontalUpperStackToVerticalStack()
        
        addHeaderToHorizontalUpperStack()
        addTimeToHorizontalUpperStack()
        
        addSecondaryTextToVerticalStack()
    }
    
    func addMainHorizontalStack() {
        self.addSubview(mainHorizontalStack)

//        applyUsualAppleConstraintsForMainHorizontalStack()
        applySnapKitConstraintsForMainHorizontalStack()
        
    }
    
    func addImageToMainHorizontalStack() {
        mainHorizontalStack.addArrangedSubview(img)
        
//        applyUsualAppleConstraintsForImage()
        applySnapKitConstraintsForImage()

    }
    
    func addVerticalStackToMainHorizontalStack() {
        // Vertical stack with .white color
        mainHorizontalStack.addArrangedSubview(verticalStack)
        
//        applyUsualAppleConstraintsForVerticalStack()
        applySnapKitConstraintsForVerticalStack()
        
    }
    
    func addHorizontalUpperStackToVerticalStack() {
        verticalStack.addArrangedSubview(horizontalUpperStack)
        
//        applyUsualAppleConstraintsForHorizontalUpperStack()
        applySnapKitConstraintsForHorizontalUpperStack()
        
    }
    
    func addHeaderToHorizontalUpperStack() {
        horizontalUpperStack.addArrangedSubview(labelHeader)
    }
    
    func addTimeToHorizontalUpperStack() {
        horizontalUpperStack.addArrangedSubview(time)
    }
    
    func addSecondaryTextToVerticalStack() {
        verticalStack.addArrangedSubview(secondaryText)
        
//        applyUsualAppleConstraintsForSecondaryText()
        applySnapKitConstraintsForSecondaryText()
        
    }
    
    // MARK: - Here goes functions that apply constrains to elements with usual Apple Tools and with SnapKit library
    
    func applyUsualAppleConstraintsForMainHorizontalStack() {
        mainHorizontalStack.translatesAutoresizingMaskIntoConstraints = false
        mainHorizontalStack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainHorizontalStack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mainHorizontalStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainHorizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func applySnapKitConstraintsForMainHorizontalStack() {
        mainHorizontalStack.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func applyUsualAppleConstraintsForImage() {
        img.translatesAutoresizingMaskIntoConstraints = false
        img.leftAnchor.constraint(equalTo: mainHorizontalStack.leftAnchor, constant: 16).isActive = true
        img.topAnchor.constraint(equalTo: mainHorizontalStack.topAnchor, constant: 16).isActive = true
        img.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -19).isActive = true
        img.widthAnchor.constraint(equalToConstant: 50).isActive = true
        img.heightAnchor.constraint(equalTo: img.widthAnchor).isActive = true
    }
    
    func applySnapKitConstraintsForImage() {
        img.snp.makeConstraints { make in
            make.left.equalTo(mainHorizontalStack.snp.left).inset(16)
            make.top.equalTo(mainHorizontalStack.snp.top).inset(16)
            make.bottom.equalTo(self.snp.bottom).inset(19)
            make.width.equalTo(50)
            make.height.equalTo(img.snp.width)
        }
    }
    
    func applyUsualAppleConstraintsForVerticalStack() {
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        verticalStack.rightAnchor.constraint(equalTo: mainHorizontalStack.rightAnchor).isActive = true
        verticalStack.leftAnchor.constraint(equalTo: img.rightAnchor, constant: 16).isActive = true
        verticalStack.topAnchor.constraint(equalTo: mainHorizontalStack.topAnchor, constant: 16).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: mainHorizontalStack.bottomAnchor, constant: -16).isActive = true
    }
    
    func applySnapKitConstraintsForVerticalStack() {
        verticalStack.snp.makeConstraints { make in
            make.right.equalTo(mainHorizontalStack.snp.right)
            make.left.equalTo(img.snp.right).offset(16)
            make.top.equalTo(mainHorizontalStack.snp.top).inset(16)
            make.bottom.equalTo(mainHorizontalStack.snp.bottom).inset(16)
        }
    }
    
    func applyUsualAppleConstraintsForHorizontalUpperStack() {
        horizontalUpperStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalUpperStack.leftAnchor.constraint(equalTo: verticalStack.leftAnchor).isActive = true
        horizontalUpperStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
    }
    
    func applySnapKitConstraintsForHorizontalUpperStack() {
        horizontalUpperStack.snp.makeConstraints { make in
            make.left.equalTo(verticalStack.snp.left)
            make.right.equalTo(self.snp.right).inset(16)
        }
    }
    
    func applyUsualAppleConstraintsForSecondaryText() {
        secondaryText.translatesAutoresizingMaskIntoConstraints = false
        secondaryText.topAnchor.constraint(equalTo: horizontalUpperStack.bottomAnchor, constant: 8).isActive = true
        secondaryText.leftAnchor.constraint(equalTo: verticalStack.leftAnchor).isActive = true
        secondaryText.rightAnchor.constraint(equalTo: verticalStack.rightAnchor, constant: -24).isActive = true
    }
    
    func applySnapKitConstraintsForSecondaryText() {
        secondaryText.snp.makeConstraints { make in
            make.top.equalTo(horizontalUpperStack.snp.bottom).offset(8)
            make.left.equalTo(verticalStack.snp.left)
            make.right.equalTo(verticalStack.snp.right).inset(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


