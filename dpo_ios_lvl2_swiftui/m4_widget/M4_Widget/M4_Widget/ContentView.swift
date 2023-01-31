//
//  ContentView.swift
//  M4_Widget
//
//  Created by Николай Ногин on 20.11.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var userText: String = ""
    @State private var textColor: Color = Color(.white)
    @State private var backColor: Color = Color(.blue)
    @State private var userDate: Date = Date()
    
    private let usrDefs = UserDefaults(suiteName: "group.nickeyprod.M4_Widget")
    
    var body: some View {
        NavigationView {
            List {
                GroupBox(label: Text("Данные виджета").font(.title)) {
                    
                    TextField("Введите ваш текст", text: $userText)
                    ColorPicker("Цвет текста:", selection: $textColor)
                    ColorPicker("Цвет фона:", selection: $backColor)
                    DatePicker(selection: $userDate, displayedComponents: .date, label: { Text("Целевая дата:")})
                    Spacer()
                    Spacer()
                    Button("Применить изменения") {
                        // store in UserDefaults
                        saveDataToUserDefs()
                    }.padding(12)
                    .border(.blue)
                }
            }
        }.onAppear {
            restoreDataFromUserDefs()
        }
    }

    
    private func saveDataToUserDefs() {
        // save text
        usrDefs?.set(userText, forKey: Constants.userData.userText)
        
        // save colors
        if let textColorCGFloat: [CGFloat] = textColor.cgColor?.components,  let backColorCGFloat: [CGFloat] = backColor.cgColor?.components {
            usrDefs?.set(textColorCGFloat, forKey: Constants.userData.textColor)
            usrDefs?.set(backColorCGFloat, forKey: Constants.userData.backColor)
        }

        //save date
        usrDefs?.set(userDate, forKey: Constants.userData.userDate)
        
    }
    
    private func restoreDataFromUserDefs() {
        if let usrText = usrDefs?.object(forKey: Constants.userData.userText) as? String,
        let textColorCGFloat = usrDefs?.object(forKey: Constants.userData.textColor) as? [CGFloat],
        let backColorCGFloat = usrDefs?.object(forKey: Constants.userData.backColor) as? [CGFloat],
           let usrDate = usrDefs?.object(forKey: Constants.userData.userDate) as? Date {

            var textColorDict: [String: CGFloat] = [:]
            var backColorDict: [String: CGFloat] = [:]
            
            for i in 0..<textColorCGFloat.count {
                if i == 0 {
                    textColorDict["red"] = textColorCGFloat[i]
                } else if i == 1 {
                    textColorDict["green"] = textColorCGFloat[i]
                } else if i == 2 {
                    textColorDict["blue"] = textColorCGFloat[i]
                } else if i == 3 {
                    textColorDict["opacity"] = textColorCGFloat[i]
                }
            }
            
            for i in 0..<backColorCGFloat.count {
                if i == 0 {
                    backColorDict["red"] = backColorCGFloat[i]
                } else if i == 1 {
                    backColorDict["green"] = backColorCGFloat[i]
                } else if i == 2 {
                    backColorDict["blue"] = backColorCGFloat[i]
                } else if i == 3 {
                    backColorDict["opacity"] = backColorCGFloat[i]
                }
            }
            
            let restoredTextColor = Color(red: textColorDict["red"] ?? 0.0, green: textColorDict["green"] ?? 0.0, blue: textColorDict["blue"] ?? 0.0, opacity: textColorDict["opacity"] ?? 0.0)
            
            let restoredBackColor = Color(red: backColorDict["red"] ?? 0.0, green: backColorDict["green"] ?? 0.0, blue: backColorDict["blue"] ?? 0.0, opacity: backColorDict["opacity"] ?? 0.0)
        
            userText = usrText
            textColor = restoredTextColor
            backColor = restoredBackColor
            userDate = usrDate
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
