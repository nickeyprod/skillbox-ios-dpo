//
//  LazyVStackHeader.swift
//  M5_Homework
//
//  Created by Николай Ногин on 24.11.2022.
//

import SwiftUI

struct LazyVStackHeader: View {
    
    let animal: Animal

    var body: some View {
        HStack {
            Text(verbatim: animal.name)
                .font(.title)
                .bold()
                .foregroundColor(.blue)
            Spacer()
        }
    }
}

