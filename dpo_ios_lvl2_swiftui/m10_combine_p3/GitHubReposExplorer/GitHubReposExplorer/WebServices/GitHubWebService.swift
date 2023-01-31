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
}

class GitHubWebService {
    
    @Published var result: [Repository] = []
    @Published var error: DataLoadError? = nil
    
    private var subscription: AnyCancellable? = nil
   
    private func getURLForReposList(orgName: String) -> URL? {
        guard let url = URL(string: "https://api.github.com/orgs/\(orgName)/repos") else { return nil }
        return url
    }
    
    private func getURLForBranchNames(orgName: String, repoName: String) -> URL? {
        guard let url = URL(string: "https://api.github.com/repos/\(orgName)/\(repoName)/branches") else { return nil}
        return url
    }
    
    
    public func makeRequest(orgName: String) {
        
        subscription = loadRepositoriesPublisher(by: orgName)
            .flatMap(maxPublishers: .max(1), { repo in
                repo.publisher
                    .flatMap { repo in
                        self.loadBranchesPublisher(by: orgName, and: repo)
                    }.collect()
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    return
                case .failure(error: let error):
                    self.error = error
                }
            }, receiveValue: { repositories in
                self.result = repositories
            })
    }
    
    // Метод загружает репозиторий по имени организации
    func loadRepositoriesPublisher(by orgName: String) -> AnyPublisher<[Repository], DataLoadError> {
        guard let url = getURLForReposList(orgName: orgName) else {
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
    
    // Метод загружает ветки по имени репозитория
    func loadBranchesPublisher(by orgName: String, and repo: Repository) -> AnyPublisher<Repository, DataLoadError> {
        guard let forReposURL = getURLForBranchNames(orgName: orgName, repoName: repo.name) else {
            return Fail(error: DataLoadError.urlParseError).eraseToAnyPublisher()
        }
        var r = repo
        return URLSession.shared.dataTaskPublisher(for: forReposURL)
            .map { $0.data }
            .decode(type: [Branch].self, decoder: JSONDecoder())
            .map { r.branches = $0; return r }
            .mapError { DataLoadError.sessionError($0)}
            .eraseToAnyPublisher()
    }
    
   
}

