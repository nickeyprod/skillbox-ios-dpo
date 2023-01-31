//
//  Item1_ViewController.swift
//  M14
//
//  Created by Николай Ногин on 25.07.2022.
//

import UIKit


// Вкладка 1 - Задание 1

class Item1_ViewController: UIViewController {
    
    let cellIdCustom = "00_08"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.tableHeaderView = tableHeader
        tableView.allowsSelection = false
        return tableView
    }()
    
    private lazy var tableHeader: UILabel = {
        let header = UILabel(frame: CGRect(x: 9, y: 9, width: 100, height: 50))
        header.text = "Список стран"
        header.font = .boldSystemFont(ofSize: CGFloat(24))
        return header
    }()
    
    private lazy var cell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Задание 1"
        
        initializeTable()
        setupConstraints()
    }
    
    private func initializeTable() {
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: cellIdCustom)
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableHeader.translatesAutoresizingMaskIntoConstraints = false
        tableHeader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        tableHeader.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 10).isActive = true
    }
}


extension Item1_ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.Countries.imageAndName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdCustom) as? CustomCell
        
        let countryData = Constants.Countries.imageAndName[indexPath.row]
        let countryNameEng = Array(countryData.keys)[0]
        let countryNameRus = countryData[countryNameEng]
        
        cell?.countryName.text = countryNameRus
        cell?.countryImage.image = UIImage(named: countryNameEng)
        return cell ?? UITableViewCell()
    }
    
    
}

extension Item1_ViewController: UITableViewDelegate {}
