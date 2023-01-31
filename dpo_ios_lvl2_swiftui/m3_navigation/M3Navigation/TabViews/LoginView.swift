//
//  LoginView.swift
//  M3Navigation
//
//  Created by Николай Ногин on 17.11.2022.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var showLoginModally: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Login Screen")
                    .font(.largeTitle)
                if showLoginModally {
                    Button("Закрыть Логин") {
                        showLoginModally = false
                    }
                    .padding(10)
                }
            }
            .navigationBarTitle(Text("Login"), displayMode: .large)
        }
    }
}
