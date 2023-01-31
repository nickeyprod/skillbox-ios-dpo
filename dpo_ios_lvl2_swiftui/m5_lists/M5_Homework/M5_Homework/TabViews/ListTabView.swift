//
//  ListTabView.swift
//  M5_Homework
//
//  Created by Николай Ногин on 24.11.2022.
//

import SwiftUI

struct ListTabView: View {
    
    let animals = DataAnimals().animals
    
    var body: some View {
        NavigationView {
            List(animals, children: \.breeds) { animal in
                AsyncImage(url: URL(string: animal.url ?? ""), placeholder: {
                    Text("Loading...")
                })
                
                .frame(width: 100, height: 80)
                .cornerRadius(20)
                .padding(10)
                Text(animal.name)
                    
            }
            .navigationTitle("List Tab View")
            
        }
    }
}


struct ListTabView_Previews: PreviewProvider {
    static var previews: some View {
        ListTabView()
    }
}

