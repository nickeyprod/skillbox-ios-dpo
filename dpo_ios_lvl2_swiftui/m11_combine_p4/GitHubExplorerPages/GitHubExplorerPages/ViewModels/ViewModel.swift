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

    private var pageToLoad: UInt = 1
    
    init() {
        $orgNameText
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { self.webService.makeRequest(orgName: $0) }
            .store(in: &store)
        
        webService.$result
            .receive(on: RunLoop.main)
            .sink { self.orgsList = $0 }
            .store(in: &store)
        
        webService.$error
            .sink { self.error = $0 }
            .store(in: &store)
        
        webService.$notFullyLoaded
            .receive(on: RunLoop.main)
            .sink { notFullyLoaded in
                if notFullyLoaded {
                    self.pageToLoad = self.pageToLoad + 1
                    self.webService.makeRequest(orgName: self.orgNameText, page: self.pageToLoad)
                } else {
                    self.pageToLoad = 1
                }
            }
            .store(in: &store)
    }
    
}
