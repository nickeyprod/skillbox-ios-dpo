//
//  CartVC.swift
//  FakeMarketplace
//
//  Created by Николай Ногин on 15.10.2022.
//

import UIKit

class CartVC: UIViewController {
    private let cellId = "123_094"
    private var itemsInCart: [Product?] = []
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsSelection = false
        tableView.contentInset = .init(top: -35, left: 0, bottom: 0, right: 0)
        return tableView
    }()

    private lazy var totalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        return stackView
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total cost: 0.0$"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Make Order", for: .normal)
        button.backgroundColor = .blue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My Cart"
        view.backgroundColor = .white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "На главную", style: .done, target: self, action: #selector(toMainPage(sender:)))
        
        // add all views in
        view.addSubview(mainStack)
        
        mainStack.addArrangedSubview(table)
        mainStack.addArrangedSubview(totalStack)
        
        totalStack.addArrangedSubview(totalLabel)
        totalStack.addArrangedSubview(buyButton)
        
        // initiate table
        table.register(CustomCell.self, forCellReuseIdentifier: cellId)
        table.delegate = self
        table.dataSource = self
        
        // make constraints
        setupConstraints()
        
        // restore cached goods in cart from cache
        self.restoreCartFromCache()
        
        // after that update total cost
        self.updateTotalCostLabel()
        
    }
    
    private func setupConstraints() {
        mainStack.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(20)
        }
        
        buyButton.snp.makeConstraints { make in
            make.width.equalTo(200)
        }
    }
    
    @objc private func toMainPage(sender: UIBarButtonItem) {
        // We go to initial VC with product categories
        self.navigationController?.popToRootViewController(animated: true)
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
    
    private func updateTotalCostLabel() {
        // just update text in label
        totalLabel.text = "Total cost: \(calculateTotalCost())$"
    }
    
    private func restoreCartFromCache() {
        // retrieve cached goods from UserDefaults
        if let data = UserDefaults.standard.object(forKey: Constants.UserDef.itemsInCard) as? Data {
            if let productsInCart = try? JSONDecoder().decode([Product].self, from: data) {
                self.itemsInCart = productsInCart
            }
        }
    }
    
    private func calculateTotalCost() -> String {
        // calculate total cost of the items in cart and return string with 2 decimal places
        var total: Float = 0
        for item in self.itemsInCart {
            let price = item?.price
            if let safePrice = price {
                total += Float(safePrice)
            }
        }
        return String(format: "%.2f", total)
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // when delete, save cart in cache
        if editingStyle == .delete {
            self.itemsInCart.remove(at: indexPath.row)
            self.table.deleteRows(at: [indexPath], with: .automatic)
            self.cacheCart()
            self.updateTotalCostLabel()
        }
    }
}


extension CartVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.itemsInCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: cellId) as! CustomCell
        guard let item = self.itemsInCart[indexPath.row] else {
            print("Error, No Item Found")
            let alert = UIAlertController(title: "Error!", message: "Error, No Goods Found!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return cell
        }
        
        cell.header.text = item.title
        cell.secondaryText.text = item.description
        let rating = item.rating
        if let rate = rating["rate"] {
            cell.rateLabel.text = "Rating: \(rate)"
            cell.priceLabel.text = "Price: \(item.price) $"
        }

        downloadImage(from: URL(string: item.image)!, placeTo: cell.img)

        return cell
    }
    
}

extension CartVC: UITableViewDelegate {}
