//
//  ViewController.swift
//  MVVM_Project
//
//  Created by Николай Ногин on 10.08.2022.
//

import UIKit
import SnapKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {
    
    private let cellId = "00_01"
    private var tableVM = TableViewModel()
    private var filmModels: [FilmModel] = [FilmModel]()
    
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
        table.register(CustomCell.self, forCellReuseIdentifier: cellId)
        table.delegate = self
        table.dataSource = self

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filmModels.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: cellId) as! CustomCell
        let film = self.filmModels[indexPath.row]
        cell.header.text = film.title
        cell.secondaryText.text = film.description
        cell.img.image = film.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        let selected = self.filmModels[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.detailVM.selectedFilm = selected
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.activityIndicator.startAnimating()
        if let safeText = searchBar.text {
            self.tableVM.search(text: safeText) {filmModels in
                self.filmModels = filmModels
                self.activityIndicator.stopAnimating()
                self.table.reloadData()
            }
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

}

