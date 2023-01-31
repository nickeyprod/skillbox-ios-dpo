//
//  ContentView.swift
//  Start_SwiftUI
//
//  Created by Николай Ногин on 20.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var opacity = 0.0
    
    var body: some View {
        
        VStack {
            Text("Hello, world!")
            Text("Nickolay")
                .padding()
        }
        .opacity(opacity)
        .onAppear {
            let baseAnimation = Animation.easeInOut(duration: 3)
            withAnimation(baseAnimation) {
                opacity = 1
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
