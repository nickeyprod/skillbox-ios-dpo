//
//  ViewModel.swift
//  GitHubReposExplorer
//
//  Created by Николай Ногин on 04.12.2022.
//

import Foundation
import Combine

final class ViewModel {
    @Published var orgsList: [Repository?] = []
    
    @Published var orgNameText: String = ""
    
    @Published var error: DataLoadError? = nil
    
    
    private var webService = GitHubWebService()
    
    private var store: Set<AnyCancellable> = []
    
    init() {
        $orgNameText
            .dropFirst()
            .sink { self.webService.makeRequest(orgName: $0) }
            .store(in: &store)
        
        webService.$result
            .sink { self.orgsList = $0 }
            .store(in: &store)
        
        webService.$error
            .sink { self.error = $0 }
            .store(in: &store)
    }
    
}
