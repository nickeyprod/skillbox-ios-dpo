//
//  ProductCardVC.swift
//  FakeMarketplace
//
//  Created by Николай Ногин on 04.10.2022.
//

import UIKit
import SnapKit

class ProductCardVC: UIViewController {
    
    private let currentProduct: Product
    private var itemsInCart: [Product?] = []
    
    init(product: Product) {
        self.currentProduct = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollContainer: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    private lazy var content: UIView = {
        let content = UIView()
        return content
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    private lazy var productLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0

        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "Rating: 3.9"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center

        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Some Description Beautiful Good thing"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        label.textAlignment = .justified

        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "159 $"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center

        return label
    }()
    
    private lazy var photoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add to cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        let img = UIImage(systemName: "cart.fill")
        let tintedImage = img?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .white
        button.setTitle("0", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return button
    }()
    
    private lazy var priceAndRatingStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 4
        return stack
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        updateNumItemsInCart()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Jewelry Product"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "На главную", style: .done, target: self, action: #selector(self.toMainPage(sender:)))
        
        view.backgroundColor = .white
        
        productLabel.text = currentProduct.title
        let rating = currentProduct.rating
        let rate = rating["rate"]
        ratingLabel.text = "Rating: \(rate!)"
        descriptionLabel.text = currentProduct.description.capitalizingFirstLetter()
        priceLabel.text = "\(currentProduct.price) $"
        
        view.addSubview(scrollContainer)
        scrollContainer.addSubview(mainStack)
        
        mainStack.addArrangedSubview(productLabel)
        mainStack.addArrangedSubview(photoStack)
        mainStack.addArrangedSubview(descriptionLabel)
        mainStack.addArrangedSubview(priceAndRatingStack)
        priceAndRatingStack.addArrangedSubview(ratingLabel)
        priceAndRatingStack.addArrangedSubview(priceLabel)
        mainStack.addArrangedSubview(buttonsStack)
        buttonsStack.addArrangedSubview(addToCartButton)
        buttonsStack.addArrangedSubview(cartButton)
        
        addToCartButton.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        populateImages()
        setupConstraints()
        addGestureRecognizers()
    }
    
    private func setupConstraints() {
        
        scrollContainer.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        mainStack.snp.makeConstraints { make in
            make.left.equalTo(scrollContainer.snp.left).inset(20)
            make.right.equalTo(scrollContainer.snp.right).inset(-20)
            make.top.equalTo(scrollContainer.snp.top).inset(20)
            make.bottom.equalTo(scrollContainer.snp.bottom)
            make.width.equalTo(scrollContainer.snp.width).offset(-40)
            
        }
        
        photoStack.snp.makeConstraints { make in
            make.height.equalTo(260)
            make.left.equalTo(mainStack.snp.left).inset(20)
            make.right.equalTo(mainStack.snp.right).inset(20)
        }

        priceAndRatingStack.snp.makeConstraints { make in
            make.width.equalTo(mainStack.snp.width).offset(-60)
        }
        
    }
    
    @objc private func toMainPage(sender: UIBarButtonItem) {
        // We go to initial VC with product categories
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func addGestureRecognizers() {
        // add tap handler to Add to Cart button
        let gesture = AddToCartTapGesture(target: self, action:  #selector(self.tappedAddToCartBtn(_:)))
        gesture.product = self.currentProduct
        addToCartButton.addGestureRecognizer(gesture)
        
        // add tap handler to Open Cart button
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(self.tappedGoToCartBtn(_:)))
        cartButton.addGestureRecognizer(gesture2)
    }
    
    private func cacheCart() {
        // To store in UserDefaults
        if let encoded = try? JSONEncoder().encode(itemsInCart) {
            UserDefaults.standard.set(encoded, forKey: Constants.UserDef.itemsInCard)
        } else {
            print("Error during saving cart state")
            let alert = UIAlertController(title: "Error!", message: "Error, couldnt save goods in cart!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func tappedGoToCartBtn(_ sender : UITapGestureRecognizer) {
        self.navigationController?.pushViewController(CartVC(), animated: true)
    }
    
    @objc private func tappedAddToCartBtn(_ sender : AddToCartTapGesture) {
        self.itemsInCart.append(currentProduct)
        self.cacheCart()
        self.updateNumItemsInCart()
    }
    
    private func updateNumItemsInCart() {
        
        // Retrieve from UserDefaults
        if let data = UserDefaults.standard.object(forKey: Constants.UserDef.itemsInCard) as? Data {
            if let productsInCart = try? JSONDecoder().decode([Product].self, from: data) {
                self.itemsInCart = productsInCart
            }
            
            cartButton.setTitle(String(self.itemsInCart.count), for: .normal)
        }
    }
    
    private func populateImages() {
        let imageView = UIImageView()
        
        if let imageURL = URL(string: currentProduct.image) {
            downloadImage(from: imageURL, placeTo: imageView)
            photoStack.addArrangedSubview(imageView)
        }

    }
}
