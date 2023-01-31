//
//  Item3_DetailNewsView.swift
//  M14
//
//  Created by Николай Ногин on 30.07.2022.
//

import UIKit

// Вкладка 3 - Детальный вид

class Item3_DetailNewsView: UIViewController {
    private var name: String
    private var location: String
    private var desc: String
    
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.textAlignment = .justified
        label.font = .systemFont(ofSize: 22)
        label.text = desc
        return label
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = location
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 0
        stackView.alignment = .top
        
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(locationLabel)
        return stackView
    }()
    
    init(name: String, location: String, desc: String) {
        self.name = name
        self.location = location
        self.desc = desc
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = name
        view.addSubview(stackView)

        setupConstraints()
    }
    
    private func setupConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: -20).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: 20).isActive = true
    }
    
}
