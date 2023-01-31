//
//  LoadDataUtils.swift
//  PracticeCombine9
//
//  Created by Roman on 11.08.2022.
//

import Foundation
import UIKit
import Combine

enum DataLoadError: Error {
    
    case emptyData
    
    case urlParseError

    case decodeError
    
    case imagesNotLoaded
    
    case sessionError(Error)
}

/// Метод ищет и загружает изображения по заданной поисковой строке
func getlistOfImageURLsPublisher(by text: String) -> AnyPublisher<[ImageItem], DataLoadError> {
    guard let url = URL(string: "https://www.googleapis.com/customsearch/v1?key=AIzaSyAeiVPf6v1Lbg8wcD0cU9vfjLi5IeNRr2w&cx=c6408953af8a44ff3&searchType=IMAGE&q=\(text)") else {
        return Fail(error: DataLoadError.urlParseError).eraseToAnyPublisher()
    }
    
    return URLSession.shared.dataTaskPublisher(for: url)
        .map { return $0.data }
        .decode(type: GoogleImages.self, decoder: JSONDecoder())
        .map { $0.items }
        .receive(on: RunLoop.main)
        .mapError { DataLoadError.sessionError($0) }
        .eraseToAnyPublisher()
        
}

// метод загружает картинки по списку из url
func loadImagesFromUrlsPublisher(by urls: [ImageItem]) -> AnyPublisher<[UIImage], DataLoadError> {
    return removeDuplicateUrls(from: urls).publisher
        .flatMap(maxPublishers: .max(1)) { url in
            URLSession.shared.dataTaskPublisher(for: url.link.absoluteURL)
                .receive(on: RunLoop.main)
                .map(\.data)
        }
        .tryMap {
            if let image = UIImage(data: $0) {
                return image
            }
            throw DataLoadError.emptyData
        }
        .mapError { DataLoadError.sessionError($0)}
        .collect()
        .eraseToAnyPublisher()
}


///// Метод удаляет дублирование ссылок на изображения в ответе сервиса
private func removeDuplicateUrls(from googleImages: [ImageItem]) -> [ImageItem] {
    var items: [ImageItem] = []
    googleImages.forEach { imageItem in
        if !items.contains(where: { $0.link == imageItem.link }) {
            items.append(imageItem)
        }
    }
    return items
}
