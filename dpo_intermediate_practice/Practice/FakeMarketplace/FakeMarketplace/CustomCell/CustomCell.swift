//
//  CustomCellNew.swift
//  FakeMarketplace
//
//  Created by Николай Ногин on 15.10.2022.
//

import UIKit
import SnapKit

class CustomCell: UITableViewCell {
    
    private lazy var mainHorizontalStack: UIStackView = {
        var stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 18
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
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var header: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var secondaryText: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var rateAndPriceStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 1
        label.textAlignment = .right
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
        rightVerticalStack.addArrangedSubview(rateAndPriceStack)
        
        // Add Price and Rate labels
        rightVerticalStack.addSubview(rateAndPriceStack)
        rateAndPriceStack.addArrangedSubview(rateLabel)
        rateAndPriceStack.addArrangedSubview(priceLabel)
        
        applyConstraintsForPriceAndRate()
        
        applyConstraintsForHeaderAndSecondaryText()
    }

    
    // MARK: - Here goes functions that apply constrains to elements
    
    func applyConstraintsForMainHorizontalStack() {
        mainHorizontalStack.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(16)
            make.bottom.equalTo(self.snp.bottom)
        }
    }
    
    func applyConstraintsForImage() {
        img.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    }
    
    func applyConstraintsForRightVerticalStack() {
        rightVerticalStack.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).inset(16)
            make.right.equalTo(self.snp.right).inset(16)
        }
    }
    
    func applyConstraintsForHeaderAndSecondaryText() {
        secondaryText.snp.makeConstraints { make in
            make.left.equalTo(rightVerticalStack.snp.left)
        }
        header.snp.makeConstraints { make in
        }
    }
    
    func applyConstraintsForPriceAndRate() {
        rateAndPriceStack.translatesAutoresizingMaskIntoConstraints = false
        rateAndPriceStack.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
