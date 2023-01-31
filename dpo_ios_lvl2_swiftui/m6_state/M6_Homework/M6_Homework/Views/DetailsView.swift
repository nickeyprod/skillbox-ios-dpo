//
//  DetailsView.swift
//  M6_Homework
//
//  Created by Николай Ногин on 27.11.2022.
//

import SwiftUI

struct DetailsView: View {
    
    @EnvironmentObject var animal: Animal
    
    var body: some View {
        List {
            ForEach(animal.breeds) { breed in
                HStack {
                    AsyncImage(url: URL(string: breed.url)) {
                        Text("Загружаю...")
                    }.frame(width: 180, height: 100)
                        .cornerRadius(100)
                    Text(breed.name)
                }
            }
            .navigationTitle(animal.name)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView().environmentObject(Animal(name: "Dog", breeds: [Breed(name: "Bulldog", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4C9uK0aKifAP_AzqJ751RA5_7utMqagTz1A&usqp=CAU"), Breed(name: "German Shepard", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAO0MSHjt7Wb7qb2fz7DgL5IHNVYJcdSflSg&usqp=CAU"), Breed(name: "Golden Retriever", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5A-lNMgybyri7ojG0yV6J7CWKqKzkQq8P0w&usqp=CAU")]))
    }
}
