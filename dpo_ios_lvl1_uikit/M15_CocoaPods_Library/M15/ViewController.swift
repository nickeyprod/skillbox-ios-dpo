//
//  ViewController.swift
//  M15
//
//  Created by Николай Ногин on 02.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let cellId = "00_02"
    
    private lazy var table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.allowsSelection = false
        return table
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTable()
        setupConstraints()
    }
    
    private func initTable() {
        table.register(CustomCell.self, forCellReuseIdentifier: cellId)
        table.dataSource = self
        table.delegate = self
        view.addSubview(table)
    }
    
    private func setupConstraints() {
        table.translatesAutoresizingMaskIntoConstraints = false
        table.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        table.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        table.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        table.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    


}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {5}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: cellId)
        return cell ?? UITableViewCell()
    }

    
}

extension ViewController: UITableViewDelegate {}
