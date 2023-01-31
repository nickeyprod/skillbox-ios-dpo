//
//  UpperPanel.swift
//  M7_Homework
//
//  Created by Николай Ногин on 28.11.2022.
//

import SwiftUI

struct UpperPanelView: View {
    
    var body: some View {
        HStack {
            Image(systemName: "antenna.radiowaves.left.and.right")
                .padding(.bottom, 10)
            Text("MTS RUS")
                .padding(.bottom, 10)
            Spacer()
            Image(systemName: "lock")
                .padding(.bottom, 10)
            Spacer(minLength: 100)
            Text("50%")
                .padding(.bottom, 10)
            Image(systemName: "battery.50")
                .padding(.bottom, 10)
        }
        .padding(.leading, 60)
        .padding(.trailing, 60)
        .font(.title2)
        .background(.black)
        .opacity(0.8)
    }
}
