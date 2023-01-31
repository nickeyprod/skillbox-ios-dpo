//
//  ViewController.swift
//  MVP_Project
//
//  Created by Николай Ногин on 10.08.2022.
//

import UIKit
import SnapKit

class TableViewController: UIViewController, UISearchBarDelegate {
    
    private var tablePresenter = TableViewPresenter()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var table: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.contentInset = .init(top: -35, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true

        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Search Films!"
        
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(table)
        
        view.addSubview(stackView)
        view.addSubview(activityIndicator)
        
        searchBar.delegate = self
        tablePresenter.dataForPresenter(self, self.table)

        setupConstraints()
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view.snp.center)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.activityIndicator.startAnimating()
        if let safeText = searchBar.text {
            self.tablePresenter.search(text: safeText) {
                self.activityIndicator.stopAnimating()
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

}

