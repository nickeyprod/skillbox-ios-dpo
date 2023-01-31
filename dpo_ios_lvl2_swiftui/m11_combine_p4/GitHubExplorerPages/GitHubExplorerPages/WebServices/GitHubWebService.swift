//
//  GitHubWebService.swift
//  GitHubReposExplorer
//
//  Created by Николай Ногин on 04.12.2022.
//

import Foundation
import Combine

enum DataLoadError: Error {
    
    case emptyData
    
    case urlParseError

    case decodeError
    
    case repositoryNotExists
    
    case sessionError(Error)
    
    case notFullData
}

class GitHubWebService {
    
    private let RECORDS_PER_PAGE: Int = 40
    
    @Published var result: [Repository] = []
    @Published var error: DataLoadError? = nil
    @Published var notFullyLoaded: Bool = false
    
    private var subscription: AnyCancellable? = nil
   
    private func getURLForReposList(orgName: String, page: UInt) -> URL? {
        guard let url = URL(string: "https://api.github.com/orgs/\(orgName)/repos?per_page=\(RECORDS_PER_PAGE)&page=\(page)") else { return nil }
        return url
    }
    
    public func makeRequest(orgName: String, page: UInt = 1) {
        
        subscription = loadRepositoriesPublisher(by: orgName, page: page)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    return
                case .failure(error: let error):
                    self.error = error
                }
            }, receiveValue: { repositories in
                
                if repositories.count == self.RECORDS_PER_PAGE {
                    self.notFullyLoaded = true
                } else {
                    self.notFullyLoaded = false
                }
                
                self.result = self.result + repositories
            })
    }
    
    // Метод загружает репозиторий по имени организации и номеру страницы
    func loadRepositoriesPublisher(by orgName: String, page: UInt) ->
    AnyPublisher<[Repository], DataLoadError> {
        guard let url = getURLForReposList(orgName: orgName, page: page) else {
            return Fail(error: DataLoadError.urlParseError).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ (data: Data, response: URLResponse) -> Data in
                    if let httpResp = response as? HTTPURLResponse {
                    if (httpResp.statusCode == 404) {
                        throw DataLoadError.repositoryNotExists
                    }
                }
                return data
            })
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .mapError { DataLoadError.sessionError($0) }
            .eraseToAnyPublisher()
    }
   
}

