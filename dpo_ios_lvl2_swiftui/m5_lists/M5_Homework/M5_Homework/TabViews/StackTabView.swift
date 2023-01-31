//
//  StackTabView.swift
//  M5_Homework
//
//  Created by Николай Ногин on 24.11.2022.
//

import SwiftUI

struct StackTabView: View {
    
    let animals = DataAnimals().animals
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(animals) { animal in
                        Divider()
                        LazyVStackHeader(animal: animal)
                        ForEach(animal.breeds ?? []) { breed in
                            LazyVStackLine(breed: breed)
                        }
                    }
                }
                .padding(20)
                .navigationTitle("Stack Tab View")
            }
        }
    }
}

struct StackTabView_Previews: PreviewProvider {
    static var previews: some View {
        StackTabView()
    }
}

