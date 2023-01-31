//
//  PeopleTextWidgetBundle.swift
//  PeopleTextWidget
//
//  Created by Николай Ногин on 20.11.2022.
//

import WidgetKit
import SwiftUI

@main
struct PeopleTextWidgetBundle: WidgetBundle {
    var body: some Widget {
        PeopleTextWidget()
        PeopleTextWidgetLiveActivity()
        PeopleTextMiddleWidget()
        PeopleTextLargeWidget()
    }
}
