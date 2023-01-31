//
//  LazyVStackLine.swift
//  M5_Homework
//
//  Created by Николай Ногин on 24.11.2022.
//


import SwiftUI

struct LazyVStackLine: View {
    
    let breed: Animal

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: breed.url ?? ""), placeholder: {
                Text(verbatim: "Loading...")
            })
            
            .frame(width: 150, height: 150)
            .cornerRadius(200)
                
            Spacer()
            Text(breed.name)
                .font(.title)
            Spacer()
        }
        .padding(.leading, 20)

    }
}



struct StackTabView_Previews2: PreviewProvider {
    static var previews: some View {
        StackTabView()
    }
}

