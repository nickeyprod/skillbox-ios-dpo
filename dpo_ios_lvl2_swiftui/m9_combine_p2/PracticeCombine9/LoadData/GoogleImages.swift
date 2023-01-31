//
//  GoogleImages.swift
//  PracticeCombine9
//
//  Created by Николай Ногин on 02.12.2022.
//

import Foundation

struct ImageItem: Decodable {
    var title: String
    var link: URL
}

/// Модель данных, возвращаемая Google Custom Search поиска изображений
struct GoogleImages: Decodable {
    var items: [ImageItem]
}
