//
//  ContentView.swift
//  M2_Layout
//
//  Created by Николай Ногин on 13.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    
    @State private var notificateUser = false
    @State private var newsNotificate = false
    @State private var friendsNotificate = false
    
    @State private var dateOFBirth = Date()
    
    @State private var selectedGender: Gender = .man
    
    @State private var alerPresented = false
    
    enum Gender: String, CaseIterable, Identifiable {
        case man, women
        var id: Self { self }
    }
    
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Личные данные")) {
                    TextField("Имя", text: $firstName)
                    TextField("Фамилия", text: $lastName)
                    DatePicker("Дата рождения",
                        selection: $dateOFBirth,
                        displayedComponents: [.date]
                    )
                    Picker("Пол", selection: $selectedGender) {
                        Text("Мужской").tag(Gender.man)
                        Text("Женский").tag(Gender.women)
                    }.pickerStyle(.navigationLink)
                }
                
                Section(header: Text("Нотификации")) {
                    Toggle(isOn: $notificateUser) {
                        Text("Получать нотификации")
                    }
                    if notificateUser {
                        Toggle(isOn: $newsNotificate) {  Text("Новости")
                        }
                        Toggle(isOn: $friendsNotificate) {
                            Text("Обновления друзей")
                        }
                    }
                }
                
                Section(header: Text("Документы")) {
                    Button("Личные данные") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    Button("Условия пользования") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                }
                
                Section() {
                    Button("Выход") {
                        alerPresented = true
                    }.foregroundColor(.red)
                        .alert("Выход", isPresented: $alerPresented) {
                            Button("Отменить", role: .cancel) {
                                alerPresented = false
                            }
                            Button("Выйти", role: .destructive) {
                                // Exit
                            }
                        }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
