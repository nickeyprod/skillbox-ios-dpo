//
//  CatalogView.swift
//  M3Navigation
//
//  Created by Николай Ногин on 17.11.2022.
//

import SwiftUI

struct CatalogView: View {
    
    @Binding var showLoginModally: Bool
    
    var body: some View {
        NavigationView {
            Text("Catalog Screen")
                .font(.largeTitle)
                .navigationBarTitle(Text("Catalog"), displayMode: .large)
                .toolbar {
                    Button("Логин Модально") {
                        showLoginModally = true
                    }
                }
                .sheet(isPresented: $showLoginModally) {
                    LoginView(showLoginModally: $showLoginModally)
                }
        }
    }
}

