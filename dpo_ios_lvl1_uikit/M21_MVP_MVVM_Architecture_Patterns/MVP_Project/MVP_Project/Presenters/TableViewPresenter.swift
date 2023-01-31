//
//  TableViewPresenter.swift
//  MVP_Project
//
//  Created by Николай Ногин on 05.09.2022.
//

import UIKit


class TableViewPresenter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "00_01"
    
    private var filmModels: [FilmModel] = [FilmModel]()
    private let tableModel: TableViewModel = TableViewModel()
    
    private var table: UITableView? = nil
    private var view: TableViewController? = nil
   
    
    func dataForPresenter(_ view: TableViewController, _ table: UITableView) {
        self.view = view
        self.table = table
        self.table?.register(CustomCell.self, forCellReuseIdentifier: cellId)
        self.table?.delegate = self
        self.table?.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filmModels.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table?.dequeueReusableCell(withIdentifier: cellId) as! CustomCell
        let film = self.filmModels[indexPath.row]
        cell.header.text = film.title
        cell.secondaryText.text = film.description
        cell.img.image = film.image
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        let selected = self.filmModels[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.detailPresenter.selectedFilm = selected
        self.view?.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func search(text: String, completionHandler: @escaping () -> Void) {
        // Actually get data from the server
        self.tableModel.getDataFromServer(searchText: text) {
            self.createFilmObjects(completionHandler: completionHandler)
        }
    }
    
    func createFilmObjects(completionHandler: @escaping () -> Void) {
        let dGroup = DispatchGroup()
        
        for film in self.tableModel.results {
            dGroup.enter()
            DispatchQueue.global(qos: .userInteractive).async {
                guard let url = URL(string: film.image),
                      let data = try? Data(contentsOf: url) else {
                    print("Ошибка, не удалось загрузить изображение")
                    return
                }
                
                DispatchQueue.main.async {
                    let filmModel = FilmModel(title: film.title, description: film.description, image: UIImage(data: data) ?? UIImage())
                    self.filmModels.append(filmModel)
                    dGroup.leave()
                }
            }
        }
        
        dGroup.notify(queue: DispatchQueue.main) { [weak self] in
            guard let self = self else { return }
            
            completionHandler()
    
            // reload table when data is loaded
            self.table?.reloadData()
        }
    }
 
}
