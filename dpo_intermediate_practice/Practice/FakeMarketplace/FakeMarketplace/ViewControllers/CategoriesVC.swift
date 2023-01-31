//
//  ViewController.swift
//  FakeMarketplace
//
//  Created by Николай Ногин on 19.09.2022.
//

import Foundation
import UIKit
import Alamofire

class CategoriesVC: UIViewController {
    
    private let categoriesURL = "https://fakestoreapi.com/products/categories"
    private var allCategories: [String] = []
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        return stack
    }()
    
    private lazy var selectCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Desirable Category:"
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var horizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray

        return view
    }()
    
    private lazy var categoriesVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalCentering
        stack.spacing = 20
        return stack
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllCategories { (data, err) in
            
            if err != nil {
                print("Error getting categories")
                let alert = UIAlertController(title: "Error!", message: "Error, couldnt load product categories!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            } else {
                let decoder = JSONDecoder()
                self.allCategories = try! decoder.decode([String].self, from: data ?? Data())
                self.activityIndicator.stopAnimating()
                
                self.populateCategories()
                self.setupConstraints()

            }
        }
        
        title = "New Fake Marketplace"
        view.backgroundColor = .white
        
        view.addSubview(mainStack)

        mainStack.addArrangedSubview(selectCategoryLabel)
        mainStack.addArrangedSubview(horizontalLine)
        mainStack.addArrangedSubview(activityIndicator)
        activityIndicator.startAnimating()
        
    }
    
    @objc private func tappedCategory(_ sender : UITapGestureRecognizer? = nil) {
        if (sender?.view?.subviews[0] is UILabel) {
            let label = sender?.view?.subviews[0] as! UILabel
            if let safeCategory = label.text?.lowercased() {
                self.navigationController?.pushViewController(ProductsVC(category: safeCategory), animated: true)
            }
        }
    }
    
    private func populateCategories() {
        let totalOfCategories = self.allCategories.count
        let numCategoriesInLine = 3
        var numberOfLines = totalOfCategories / numCategoriesInLine

        let remainder = totalOfCategories % numCategoriesInLine
        if (remainder > 0) { numberOfLines += 1 }
        var numInserted = 0
        var stoppedAt = 0
        
        var horizontalStackLine: UIStackView = UIStackView()
        
        for _ in 0 ..< numberOfLines {

            horizontalStackLine = UIStackView()

            horizontalStackLine.distribution = .fillEqually
            horizontalStackLine.spacing = 10
            
            for i in stoppedAt ..< allCategories.count {
                
                let categoryStack = UIStackView()
                categoryStack.axis = .vertical
                categoryStack.spacing = 5
                
                // add tap handler
                let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.tappedCategory(_:)))
                categoryStack.addGestureRecognizer(gesture)
                
                let categoryLabel = UILabel()
                categoryLabel.text = allCategories[i].capitalized
                categoryLabel.numberOfLines = 0
                categoryLabel.font = UIFont(name: "GemunuLibre-Regular", size: 21)
            
                
                let categoryImage = UIImageView(image: UIImage(named: allCategories[i]))
                
                categoryImage.contentMode = .scaleAspectFill
                
                categoryImage.layer.cornerRadius = 12
                categoryImage.clipsToBounds = true
                
                categoryImage.layer.borderWidth = 1
                categoryImage.layer.borderColor = UIColor.black.cgColor
                
                categoryImage.translatesAutoresizingMaskIntoConstraints = true
                categoryImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
                
                categoryStack.addArrangedSubview(categoryLabel)
                categoryStack.addArrangedSubview(categoryImage)
                
                horizontalStackLine.addArrangedSubview(categoryStack)
                
                numInserted += 1
                stoppedAt += 1
                
                if (numInserted == numCategoriesInLine) {
                    numInserted = 0
                    break
                }
                
                if (remainder == 1 && i == self.allCategories.count - 1) {
                    categoryStack.widthAnchor.constraint(equalToConstant: 120).isActive = true
                }
                else if (remainder == 2 && i == self.allCategories.count - 2) {
                    categoryStack.widthAnchor.constraint(equalToConstant: 120).isActive = true
                }
            }

            categoriesVerticalStack.addArrangedSubview(horizontalStackLine)
        }
       
        mainStack.addArrangedSubview(categoriesVerticalStack)
    }
    
    private func setupConstraints() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        mainStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true

        selectCategoryLabel.translatesAutoresizingMaskIntoConstraints = false
        selectCategoryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        horizontalLine.topAnchor.constraint(equalTo: selectCategoryLabel.bottomAnchor, constant: 5).isActive = true
        horizontalLine.leftAnchor.constraint(equalTo: mainStack.leftAnchor, constant: 10).isActive = true
        horizontalLine.rightAnchor.constraint(equalTo: mainStack.rightAnchor, constant: -10).isActive = true
        
        categoriesVerticalStack.translatesAutoresizingMaskIntoConstraints = false
        categoriesVerticalStack.topAnchor.constraint(equalTo: selectCategoryLabel.bottomAnchor, constant: 20).isActive = true
        categoriesVerticalStack.leftAnchor.constraint(equalTo: mainStack.leftAnchor).isActive = true
        categoriesVerticalStack.rightAnchor.constraint(equalTo: mainStack.rightAnchor).isActive = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func getAllCategories(completion: @escaping ( Data?, String?) -> Void) {
        AF.request(
            categoriesURL,
            method: .get
        ).response { response in
            
            guard response.error == nil else {
                return completion(nil, response.error?.localizedDescription)
            }
            
            completion(response.data, nil)
        }
    }
    
}

