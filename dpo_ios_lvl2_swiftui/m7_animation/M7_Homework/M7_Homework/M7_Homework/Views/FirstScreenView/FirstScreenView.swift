//
//  ContentView.swift
//  M7_Homework
//
//  Created by Николай Ногин on 27.11.2022.
//

import SwiftUI

struct FirstScreenView: View {
    
    @State var showView = false
    
    var body: some View {
        
        let scaleRotation = AnyTransition.modifier(active: ScaleRotationModifier(active: true), identity: ScaleRotationModifier(active: false))
        
        ZStack {
            VStack {
                UpperPanelView()
                Spacer(minLength: 250)
                TimeScreenView()
                Spacer(minLength: 300)
                SliderPanelView(showView: $showView)
                Spacer()
            }
            .foregroundColor(.white)
            .background {
                Image("water-1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(.all)
            }
            if showView {
                SecondScreenView(showView: $showView)
                    .zIndex(1)
                    .transition(scaleRotation)
            }
        }
    }
}

struct FirstScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FirstScreenView()
    }
}
