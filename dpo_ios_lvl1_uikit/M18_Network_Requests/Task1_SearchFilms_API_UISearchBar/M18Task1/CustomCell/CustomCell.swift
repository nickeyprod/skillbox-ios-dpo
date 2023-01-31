//
//  CustomCell.swift
//  M18Homework
//
//  Created by Николай Ногин on 10.08.2022.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    
    private lazy var mainHorizontalStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var img: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 8
        img.clipsToBounds = true

        return img
    }()
    
    private lazy var rightVerticalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    lazy var header: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.headerColor
        label.font = UIFont(name: Constants.Fonts.interSemiBold, size: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var secondaryText: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.textColor
        label.font = UIFont(name: Constants.Fonts.interRegular, size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Add main horizontal stack full width with the cell
        self.addSubview(mainHorizontalStack)
        applyConstraintsForMainHorizontalStack()
        
        // Add image to main horizontal stack
        mainHorizontalStack.addArrangedSubview(img)
        applyConstraintsForImage()
        
        // Add right side vertical stack to main horizontal stack
        mainHorizontalStack.addArrangedSubview(rightVerticalStack)
        applyConstraintsForRightVerticalStack()

        // Add Header and Secondary Text to right vertical stack
        rightVerticalStack.addArrangedSubview(header)
        rightVerticalStack.addArrangedSubview(secondaryText)
        
        applyConstraintsForHeaderAndSecondaryText()
    }

    
    // MARK: - Here goes functions that apply constrains to elements
    
    func applyConstraintsForMainHorizontalStack() {
        mainHorizontalStack.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func applyConstraintsForImage() {
        img.snp.makeConstraints { make in
            make.top.equalTo(mainHorizontalStack.snp.top).inset(16)
            make.bottom.equalTo(self.snp.bottom).inset(16)
            make.left.equalTo(self.snp.left).inset(16)
            make.width.equalTo(140)
            make.height.equalTo(img.snp.width)
        }
    }
    
    func applyConstraintsForRightVerticalStack() {
        rightVerticalStack.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(16)
        }
    }
    
    func applyConstraintsForHeaderAndSecondaryText() {
        secondaryText.snp.makeConstraints { make in
            make.left.equalTo(rightVerticalStack.snp.left)
            make.right.equalTo(rightVerticalStack.snp.right).inset(24)
            
            make.left.equalTo(img.snp.right).offset(8)

        }
        header.snp.makeConstraints { make in
            make.left.equalTo(img.snp.right).offset(8)
            make.right.equalTo(rightVerticalStack.snp.right)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
