//
//  TableViewModel.swift
//  MVVM_Project
//
//  Created by Николай Ногин on 06.09.2022.
//

import Foundation
import UIKit

class TableViewModel {
    private var resultsModel = ResultsModel()
    
    private var filmModels: [FilmModel] = [FilmModel]()
    
    private let APIKEY = "k_6y7nkemp"
    
    func search(text: String, completionHandler: @escaping (_ filmModels: [FilmModel]) -> Void) {
        // Actually get data from the server
        self.getDataFromServer(searchText: text) {
            self.createFilmObjects(completionHandler: completionHandler )
        }
    }
    
    func createFilmObjects(completionHandler: @escaping (_ filmModels: [FilmModel]) -> Void) {
        let dGroup = DispatchGroup()
        
        for film in self.resultsModel.results {
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
            
            completionHandler(self.filmModels)
        }
    }
    
    func getDataFromServer(searchText: String, completionHandler: @escaping () -> Void ) {
        let url = URL(string: "https://imdb-api.com/en/API/Search/\(APIKEY)/\(searchText)")
        if let safeUrl = url {
            let req = URLRequest(url: safeUrl)
            let task = URLSession.shared.dataTask(with: req) { (data, resp, err) in
                DispatchQueue.main.async { [weak self] in
                    if let err = err {
                        print(err)
                    } else {
                        guard let self = self else { return }
                        if let data = data {
                            let decoder = JSONDecoder()
                            if let jsonFilms = try? decoder.decode(ListOfFilms.self, from: data) {
                                self.resultsModel.results = jsonFilms.results

                                completionHandler()
                            } else {
                                print("===== ==== === ERROR: ===== ===== =====")
                                print("Bad response from the server....")
                                self.resultsModel.results = [self.resultsModel.errorItem]
                                completionHandler()
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
