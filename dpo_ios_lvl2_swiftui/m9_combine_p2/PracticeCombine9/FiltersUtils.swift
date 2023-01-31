//
//  FiltersUtils.swift
//  PracticeCombine9
//
//  Created by Roman on 11.08.2022.
//

import Foundation
import UIKit
import Combine

private let filterNames = [
    "CIPhotoEffectChrome",
    "CIPhotoEffectFade",
    "CIPhotoEffectInstant",
    "CIPhotoEffectMono",
    "CIPhotoEffectNoir",
    "CIPhotoEffectProcess",
    "CIPhotoEffectTonal",
    "CIPhotoEffectTransfer",
    "CISepiaTone",
]

/// Применяет к изображениею случайновыбранные фильтры.
/// - Parameters:
///   - image: Исходное изображение
///   - completion: Замыкание с результирующим изображением.
///   
func getRandomFilters() -> AnyPublisher<String, Never> {
    // Используем от одного до четырех доступных фильтров, выбираем их случайным образом
    let filtersCount = Int.random(in: (1...4))
    let filtersNames = Array(filterNames.shuffled().dropLast(filterNames.count - filtersCount))
    return filtersNames.publisher.eraseToAnyPublisher()
}

extension UIImage {
    
    /// Применяет к изображению фильтр с переданным именем.
    /// - Parameter filterName: Имя фильтра.
    /// - Returns: Изображение с примененным фильтром.
    func applyFilter(_ filterName: String) -> UIImage {
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: self)
        let filter = CIFilter(name: filterName)
        filter!.setDefaults()
        filter!.setValue(coreImage, forKey: kCIInputImageKey)
        let filteredImageData = filter!.value(forKey: kCIOutputImageKey) as! CIImage
        guard let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent) else {
            return self
        }
        return UIImage(cgImage: filteredImageRef)
    }
}
