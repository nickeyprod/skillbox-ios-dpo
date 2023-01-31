//
//  CustomTapGestures.swift
//  FakeMarketplace
//
//  Created by Николай Ногин on 05.11.2022.
//

//import Foundation
import SwiftUI

class ProductTapGesture: UITapGestureRecognizer {
    var product: Product?
}

class AddToCartTapGesture: UITapGestureRecognizer {
    var product: Product?
}

class GoToCartTapGesture: UITapGestureRecognizer {
    var product: Product?
}
