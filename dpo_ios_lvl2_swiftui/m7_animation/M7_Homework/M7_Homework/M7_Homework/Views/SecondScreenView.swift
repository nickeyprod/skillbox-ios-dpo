//
//  SecondScreenView.swift
//  M7_Homework
//
//  Created by Николай Ногин on 28.11.2022.
//

import SwiftUI

struct SecondScreenView: View {
    
    @Binding var showView: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button("Назад") {
                    withAnimation {
                        showView = false
                    }
                }
                .padding(12)
                .font(.largeTitle)
                .bold()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white, lineWidth: 5)
                ).foregroundColor(.white)
            }
            Spacer()
            Spacer()
        }.background(
            Image("water-2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
        )
    }
}


struct SecondScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreenView(showView: Binding.constant(false))
    }
}
