//
//  CustomModifier.swift
//  M7_Homework
//
//  Created by Николай Ногин on 28.11.2022.
//

import SwiftUI

struct ScaleRotationModifier: ViewModifier & Animatable {

    var scale: CGFloat = 1.0
    var angle: CGFloat = -360.0
    
    init(active: Bool) {
        self.progress = active ? 0 : 1
    }
    
    var progress: CGFloat
    
    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }
    
    func body(content: Content) -> some View {
        return content.scaleEffect(scale * progress)
            .rotationEffect(Angle(degrees: angle * progress))
    }
}
