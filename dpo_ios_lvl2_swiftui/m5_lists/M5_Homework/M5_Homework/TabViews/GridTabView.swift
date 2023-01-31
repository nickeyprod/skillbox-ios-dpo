//
//  GridTabView.swift
//  M5_Homework
//
//  Created by Николай Ногин on 24.11.2022.
//

import SwiftUI

struct GridTabView: View {
    
    let animals = DataAnimals().animals
    
    var columns:  [GridItem] = [
        .init(.fixed(180)),
        .init(.fixed(180))
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(animals) { animal in
                    Divider()
                    HStack {
                        Text(animal.name)
                            .foregroundColor(.blue)
                            .font(.title)
                            .bold()
                        Spacer()
                    }.padding(.leading, 20)
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(animal.breeds ?? []) { breed in
                            CellUnitView(breed: breed)
                        }
                    }

                }
            }.padding(.top, 30)
            .navigationTitle("Grid Tab View")
        }
    }
}

struct GridTabView_Previews: PreviewProvider {
    static var previews: some View {
        GridTabView()
    }
}

