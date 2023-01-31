//
//  ContentView.swift
//  Pushes
//
//  Created by Николай Ногин on 09.12.2022.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    // Schedule the request with the system.
    let notificationCenter = UNUserNotificationCenter.current()
    let uuidString = UUID().uuidString
    @State var labelText = "Нажмите отправить, чтобы получить уведомление через 10 секунд."
    
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Text(labelText)
            Spacer()
            Button("Отправить уведомления") {
                labelText = "Заблокируйте телефон или сверните приложение."
                sendLocalNotification()
            }
            .padding(15)
            .background( .blue)
            .foregroundColor(.white)
            Spacer()
            Button("Отменить уведомления") {
                labelText = "Уведомления отменены."
                notificationCenter.removePendingNotificationRequests(withIdentifiers: [uuidString])
            }
            .padding(10)
            .background(.red)
            Spacer()
            
        }.onAppear(perform: {
            requestNotifications()
        })
        .padding()
    }
    
    func sendLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "у вас новое уведомление"
        content.body = "Оно появилось через 10 секунд"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "koncovk.mp3") )
            
        let timeInterval = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    
        // Create the request
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: timeInterval)

        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
               print("error occured \(String(describing: error))")
           }
        }
    }
    
    func requestNotifications() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            // If `granted` is `true`, you're good to go!
            print(granted)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
