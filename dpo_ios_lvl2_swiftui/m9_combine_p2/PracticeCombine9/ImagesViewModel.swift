//
//  ImagesViewModel.swift
//  PracticeCombine9
//
//  Created by Николай Ногин on 02.12.2022.
//

import Foundation
import Combine
import UIKit


final class ImagesViewModel {
    @Published var searchText: String = ""
    @Published var images: [UIImage] = []
    @Published var error: Error = DataLoadError.imagesNotLoaded
    @Published var searchStarted: Bool = false
    
    private var subscription: AnyCancellable? = nil
    
    init() {
        createSubscription()
    }
    
    func createSubscription() {
        subscription = $searchText
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .removeDuplicates()
            .dropFirst(1)
            .flatMap { text in
                print(text)
                self.searchStarted = true
                return getlistOfImageURLsPublisher(by: text)
            }
            .flatMap { urls in
                return loadImagesFromUrlsPublisher(by: urls)
            }
            .sink(receiveCompletion: { completion in
                self.searchStarted = false
                
                // после ошибки подписка перестает работать, здесь мы ее пересоздаем заново
                self.createSubscription()
                
                switch completion {
                case .finished:
                    return
                case .failure(error: let error):
                    self.error = error
                }

            }) { images in
                self.images = images
                self.searchStarted = false
            }
    }
}
