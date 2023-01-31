//
//  Item3_ViewController.swift
//  M14
//
//  Created by Николай Ногин on 25.07.2022.
//

import UIKit


// Вкладка 3 - Задание 3

class Item3_ViewController: UIViewController {
    
    private let cellId = "00_07"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.tableHeaderView = tableHeader
        return tableView
    }()
    
    private lazy var tableHeader: UILabel = {
        let header = UILabel(frame: CGRect(x: 9, y: 9, width: 100, height: 50))
        header.text = "Новости с локациями"
        header.font = .boldSystemFont(ofSize: CGFloat(24))
        return header
    }()
    
//    private lazy var cell: UITableViewCell = {
//        let cell = UITableViewCell()
//        return cell
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Задание 3"
        
        initializeTable()
        setupConstraints()
    }
    
    private func initializeTable() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
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


extension Item3_ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Constants.NewsWithLocation.Models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        cell?.textLabel?.text = Constants.NewsWithLocation.Models[indexPath.row].name
        cell?.accessoryType = .disclosureIndicator
        return cell ?? UITableViewCell()
    }
    
}

extension Item3_ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let name = Constants.NewsWithLocation.Models[indexPath.row].name
        let location = Constants.NewsWithLocation.Models[indexPath.row].location
        let description = Constants.NewsWithLocation.Models[indexPath.row].description
        let vc = Item3_DetailNewsView(name: name, location: location, desc: description)

        navigationController?.pushViewController(vc, animated: true)
    }
}
