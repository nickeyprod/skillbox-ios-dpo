//
//  Fish.swift
//  M20_Homework
//
//  Created by Николай Ногин on 24.08.2022.
//
import SwiftUI

class Fish {
    var isCatched = false
    var isMoving = false
    var imageView: UIImageView

    init(imageView: UIImageView) {
        self.imageView = imageView
    }
}
