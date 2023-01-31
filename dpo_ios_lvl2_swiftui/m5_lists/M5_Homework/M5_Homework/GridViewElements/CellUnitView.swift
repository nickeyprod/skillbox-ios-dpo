//
//  CellUnit.swift
//  M5_Homework
//
//  Created by Николай Ногин on 24.11.2022.
//
import SwiftUI

struct CellUnitView: View {
    
    let breed: Animal

    var body: some View {
        ZStack(alignment: .bottom) {
            
            AsyncImage(url: URL(string: breed.url ?? ""), placeholder: {
                Text(verbatim: "Loading...")
            })
            .frame(width: 180, height: 180)
            .cornerRadius(200)

            Text(breed.name)
                .padding([.top, .bottom], 4)
                .padding([.leading, .trailing], 2)
                .background(.white)
                .cornerRadius(10)
                .opacity(0.8)
                .padding(.bottom, 30)
        }

    }
}




struct CellUnitView_Previews: PreviewProvider {
    static var previews: some View {
        CellUnitView(breed: Animal(name: "German Shepard", url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAO0MSHjt7Wb7qb2fz7DgL5IHNVYJcdSflSg&usqp=CAU"))
    }
}
