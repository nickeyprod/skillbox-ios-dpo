//
//  TimeScreenView.swift
//  M7_Homework
//
//  Created by Николай Ногин on 28.11.2022.
//

import SwiftUI

struct TimeScreenView: View {
    
    var body: some View {
        Text(Calendar.current.startOfDay(for: Date()), style: .timer)
            .font(.largeTitle)
            .bold()
    }
}
