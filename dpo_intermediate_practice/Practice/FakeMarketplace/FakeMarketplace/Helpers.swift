//
//  Helpers.swift
//  FakeMarketplace
//
//  Created by Николай Ногин on 04.10.2022.
//

import UIKit

func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}

func downloadImage(from url: URL, placeTo: UIImageView) {

    getData(from: url) { data, response, error in
        guard let data = data, error == nil else { return }
        // always update the UI from the main thread
        DispatchQueue.main.async() {
            placeTo.image = UIImage(data: data)
        }
    }
}
