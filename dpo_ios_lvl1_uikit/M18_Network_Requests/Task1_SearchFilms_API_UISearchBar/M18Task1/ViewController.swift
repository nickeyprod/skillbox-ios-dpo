//
//  ViewController.swift
//  M18Homework
//
//  Created by Николай Ногин on 10.08.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let cellId = "00_01"
    private let APIKEY = "k_6y7nkemp"
    private var results: [Film] = [Film]()
    private var filmObjects: [FilmObject] = [FilmObject]()
    private let errorItem: Film = Film(
        description: "Bad Response From The Server", id: "1",
        image: Constants.errorImg, title: "ERROR OCCURED"
    )
    
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
        tableView.allowsSelection = false
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
        
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(table)
        
        view.addSubview(stackView)
        view.addSubview(activityIndicator)
        
        table.register(CustomCell.self, forCellReuseIdentifier: cellId)
        table.delegate = self
        table.dataSource = self
        searchBar.delegate = self

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
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: cellId) as! CustomCell
        let film = self.filmObjects[indexPath.row]
        cell.header.text = film.title
        cell.secondaryText.text = film.description
        cell.img.image = film.image
        return cell
    }
    
    
}


extension ViewController: UITableViewDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Start Activity Indicator
        activityIndicator.startAnimating()
        
        if let safeText = searchBar.text {

            let url = URL(string: "https://imdb-api.com/en/API/Search/\(APIKEY)/\(safeText)")
            
            if let safeUrl = url {
                let req = URLRequest(url: safeUrl)
                
                DispatchQueue.global(qos: .userInitiated).async {
                    // Actually get data from the server
                    self.getDataFromServer(req: req)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension ViewController: UISearchBarDelegate {
    
    func getDataFromServer(req: URLRequest) {
        let task = URLSession.shared.dataTask(with: req) { (data, resp, err) in
            DispatchQueue.main.async { [weak self] in
                if let err = err {
                    print(err)
                } else {
                    guard let self = self else { return }
                    if let data = data {
                        let decoder = JSONDecoder()
                        if let jsonFilms = try? decoder.decode(ListOfFilms.self, from: data) {
                            self.results = jsonFilms.results
                            self.createFilmObjects()
                        } else {
                            print("===== ==== === ERROR: ===== ===== =====")
                            print("Bad response from the server....")
                            self.results.append(self.errorItem)
                        }
                    }
                }
            }
        }
        task.resume()
    }

    func createFilmObjects() {
        let dGroup = DispatchGroup()
        
        for film in self.results {
            dGroup.enter()
            DispatchQueue.global(qos: .userInteractive).async {
                guard let url = URL(string: film.image),
                      let data = try? Data(contentsOf: url) else {
                    print("Ошибка, не удалось загрузить изображение")
                    return
                }
                
                DispatchQueue.main.async {
                    let filmObj = FilmObject(title: film.title, description: film.description, image: UIImage(data: data) ?? UIImage())
                    self.filmObjects.append(filmObj)
                    dGroup.leave()
                }
            }
        }
        
        dGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            
            // Stop Activity Indicator
            self.activityIndicator.stopAnimating()

            // reload table when data is loaded
            self.table.reloadData()

        }
    }
}


