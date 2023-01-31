//
//  SubCategoriesVC.swift
//  FakeMarketplace
//
//  Created by Николай Ногин on 03.10.2022.
//

import Foundation
import Alamofire

import UIKit

class ProductsVC: UIViewController {
    
    private let currentCategory: String
    private let productsURL: String
    private var allProductsInCategory: [Product?] = []
    
    init(category: String) {
        self.currentCategory = category
        self.productsURL = "https://fakestoreapi.com/products/category/\(self.currentCategory)"
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        return stack
    }()
    
    private lazy var selectProductlabel: UILabel = {
        let label = UILabel()
        label.text = "Select Product:"
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textColor = .blue
        label.textAlignment = .center
        return label
    }()
    
    private lazy var horizontalLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var productsVerticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .equalCentering
        stack.spacing = 20
        return stack
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.backgroundColor = .gray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllProducts { (data, err) in
            
            if err != nil {
                print("Error getting products")
                let alert = UIAlertController(title: "Error!", message: "Error, couldnt load goods from the website", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            } else {
                let decoder = JSONDecoder()
                self.allProductsInCategory = try! decoder.decode([Product].self, from: data ?? Data())
                self.activityIndicator.stopAnimating()
                
                self.populateProducts()
                self.setupConstraints()

            }
        }

        title = self.currentCategory.capitalizingFirstLetter()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "На главную", style: .done, target: self, action: #selector(self.toMainPage(sender:)))
        
        view.backgroundColor = .white
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        mainStack.addArrangedSubview(selectProductlabel)
        mainStack.addArrangedSubview(horizontalLine)
        mainStack.addArrangedSubview(productsVerticalStack)
    }
    
    @objc private func toMainPage(sender: UIBarButtonItem) {
        // We go to initial VC with product categories
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupConstraints() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        mainStack.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
        horizontalLine.translatesAutoresizingMaskIntoConstraints = false
        horizontalLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        horizontalLine.topAnchor.constraint(equalTo: selectProductlabel.bottomAnchor, constant: 5).isActive = true
        horizontalLine.leftAnchor.constraint(equalTo: mainStack.leftAnchor, constant: 10).isActive = true
        horizontalLine.rightAnchor.constraint(equalTo: mainStack.rightAnchor, constant: -10).isActive = true
        
        productsVerticalStack.translatesAutoresizingMaskIntoConstraints  = false
        productsVerticalStack.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 15).isActive = true
        productsVerticalStack.leftAnchor.constraint(equalTo: mainStack.leftAnchor).isActive = true
        productsVerticalStack.rightAnchor.constraint(equalTo: mainStack.rightAnchor).isActive = true
    }
    
    private func getAllProducts(completion: @escaping ( Data?, String?) -> Void) {
        guard let encodedURL = productsURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        AF.request(
            encodedURL,
            method: .get
        ).response { response in
            
            guard response.error == nil else {
                return completion(nil, response.error?.localizedDescription)
            }
            completion(response.data, nil)
        }
    }
    
    @objc private func tappedProduct(_ sender : ProductTapGesture) {
        if let safeProduct = sender.product {
            self.navigationController?.pushViewController(ProductCardVC(product: safeProduct), animated: true)
        }
    }

    private func populateProducts() {
        let totalOfProducts = self.allProductsInCategory.count
        let numProductsInLine = 3
        var numberOfLines = totalOfProducts / numProductsInLine

        let remainder = totalOfProducts % numProductsInLine
        if (remainder > 0) { numberOfLines += 1 }
        var numInserted = 0
        var stoppedAt = 0

        var horizontalStackLine: UIStackView = UIStackView()

        for _ in 0 ..< numberOfLines {
            horizontalStackLine = UIStackView()
   
            horizontalStackLine.axis = .horizontal
            horizontalStackLine.distribution = .fillEqually
            horizontalStackLine.spacing = 10

            for i in stoppedAt ..< self.allProductsInCategory.count {
                
                guard let product = self.allProductsInCategory[i] else {
                    print("Error: No Products")
                    let alert = UIAlertController(title: "Error!", message: "Error, couldnt find any goods!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return;
                }
                
                let productStack = UIStackView()
                
                productStack.axis = .vertical
                productStack.distribution = .fill
                productStack.spacing = 5
                
                
                // add tap handler
                let gesture = ProductTapGesture(target: self, action:  #selector(self.tappedProduct(_:)))
                if let safeProduct = self.allProductsInCategory[i] {
                    gesture.product = safeProduct
                }
                    
                productStack.addGestureRecognizer(gesture)
                
                let productLabel = UILabel()
                
                productLabel.text = product.title
                productLabel.textAlignment = .left
                productLabel.numberOfLines = 0
                productLabel.font = UIFont(name: "GemunuLibre-Regular", size: 18)
                
                let labelHorizontalStack = UIStackView()
                labelHorizontalStack.axis = .horizontal
                labelHorizontalStack.alignment = .bottom
                labelHorizontalStack.addArrangedSubview(productLabel)
  
                
                let imgPriceStack = UIStackView()
                imgPriceStack.axis = .vertical
                imgPriceStack.spacing = 4
                imgPriceStack.distribution = .fill
                
                let productImage = UIImageView()
                
                downloadImage(from: URL(string: product.image)!, placeTo: productImage)
                
                productImage.contentMode = .scaleToFill
                
                productImage.layer.cornerRadius = 12
                productImage.clipsToBounds = true
                
                productImage.layer.borderWidth = 1
                productImage.layer.borderColor = UIColor.black.cgColor
                
                productImage.translatesAutoresizingMaskIntoConstraints = true
                productImage.heightAnchor.constraint(equalToConstant: 100).isActive = true

                
                let priceDouble: Double? = product.price
               
                let productPrice = UILabel()
                productPrice.text = "\(priceDouble!) $"
                
                productPrice.numberOfLines = 1
                productPrice.font = UIFont.systemFont(ofSize: 16)
                productPrice.textAlignment = .right
                
                imgPriceStack.addArrangedSubview(productImage)
                imgPriceStack.addArrangedSubview(productPrice)
                
                productStack.addArrangedSubview(labelHorizontalStack)
                productStack.addArrangedSubview(imgPriceStack)
                
                horizontalStackLine.addArrangedSubview(productStack)
                
                numInserted += 1
                stoppedAt += 1

                if (numInserted == numProductsInLine) {
                    numInserted = 0
                    break
                }
                
                if (remainder == 1 && i == self.allProductsInCategory.count - 1) {
                    productStack.widthAnchor.constraint(equalToConstant: 120).isActive = true
                }
                else if (remainder == 2 && i == self.allProductsInCategory.count - 2) {
                    productStack.widthAnchor.constraint(equalToConstant: 120).isActive = true
                }
            }
            
            productsVerticalStack.addArrangedSubview(horizontalStackLine)
       
        }
    }
    
}


