//
//  PeopleTextWidget.swift
//  PeopleTextWidget
//
//  Created by Николай Ногин on 20.11.2022.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    private let usrDefs = UserDefaults(suiteName: "group.nickeyprod.M4_Widget")
    
    func placeholder(in context: Context) -> SimpleEntry {
        // Get data from user defaults
        let userData = restoreDataFromUserDefs()
        
        return SimpleEntry(date: Date(), userText: userData.0, textColor: userData.1, backColor: userData.2, userDate: userData.3, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        
        // Get data from user defaults
        let userData = restoreDataFromUserDefs()
        
        let entry = SimpleEntry(date: Date(), userText: userData.0, textColor: userData.1, backColor: userData.2, userDate: userData.3, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Get data from user defaults
        let userData = restoreDataFromUserDefs()
                
        entries.append(SimpleEntry(date: Date(), userText: userData.0, textColor: userData.1, backColor: userData.2, userDate: userData.3, configuration: configuration))
        
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    private func restoreDataFromUserDefs() -> (String, Color, Color, Date) {
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
    
            return (usrText, restoredTextColor, restoredBackColor, usrDate)
        }
        return ("Example", .white, .black, Date())
    }
}

struct SimpleEntry: TimelineEntry {
    // this is a structure of data that we want to display in widget
    let date: Date
    let userText: String
    let textColor: Color
    let backColor: Color
    let userDate: Date
    let configuration: ConfigurationIntent
}

struct PeopleTextWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            entry.backColor
            VStack {
                Spacer()
                Text(entry.userText)
                    .font(.title2)
                    .foregroundColor(entry.textColor)
                Spacer()
                Text(Calendar.current.startOfDay(for: entry.userDate), style: .relative).multilineTextAlignment(.center)
                Spacer()

            }
        }
    }
}

struct PeopleTextMiddleWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            entry.backColor
            VStack {
                Spacer()
                Text(entry.userText)
                    .font(.title)
                    .foregroundColor(entry.textColor)
                Spacer()
                Text(Calendar.current.startOfDay(for: entry.userDate), style: .relative).multilineTextAlignment(.center)
                    .font(.title2)
                Spacer()
            }
        }
    }
}

struct PeopleTextLargeWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack {
            entry.backColor
            VStack {
                Spacer()
                Text(entry.userText)
                    .font(.largeTitle)
                    .foregroundColor(entry.textColor)
                Spacer()
                Text(Calendar.current.startOfDay(for: entry.userDate), style: .relative).multilineTextAlignment(.center)
                    .font(.title)
                Spacer()
            }
        }
    }
}




struct PeopleTextWidget: Widget {
    let kind: String = "PeopleTextWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            PeopleTextWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Мой дисплей - мини")
        .description("Показывает мини текст, введенный пользователем цветами выбранными пользователем и время до выбранной даты")
        .supportedFamilies([.systemSmall])
    }
}

struct PeopleTextMiddleWidget: Widget {
    let kind: String = "PeopleTextMiddleWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            PeopleTextMiddleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Мой дисплей - средний")
        .description("Показывает средний текст, введенный пользователем цветами выбранными пользователем и время до выбранной даты")
        .supportedFamilies([.systemMedium])
    }
}

struct PeopleTextLargeWidget: Widget {
    let kind: String = "PeopleTextLargeWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            PeopleTextLargeWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Мой дисплей - большой")
        .description("Показывает большой текст, введенный пользователем цветами выбранными пользователем и время до выбранной даты")
        .supportedFamilies([.systemLarge])
    }
}

struct PeopleTextWidget_Previews: PreviewProvider {
    static var previews: some View {
        PeopleTextWidgetEntryView(entry: SimpleEntry(date: Date(), userText: "Lolly", textColor: .green, backColor: .yellow, userDate: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
