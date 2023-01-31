//
//  Extensions.swift
//  FakeMarketplace
//
//  Created by Николай Ногин on 03.10.2022.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
