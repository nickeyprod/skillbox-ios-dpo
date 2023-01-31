//
//  TableViewModel.swift
//  MVP_Project
//
//  Created by Николай Ногин on 05.09.2022.
//

import UIKit

class TableViewModel {
    
    var results: [Film] = [Film]()
    private let APIKEY = "k_6y7nkemp"
    
    private let errorItem: Film = Film(
        description: "Bad Response From The Server", id: "1",
        image: Constants.errorImg, title: "ERROR OCCURED"
    )
    
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
                                self.results = jsonFilms.results

                                completionHandler()
                            } else {
                                print("===== ==== === ERROR: ===== ===== =====")
                                print("Bad response from the server....")
                                self.results = [self.errorItem]
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
