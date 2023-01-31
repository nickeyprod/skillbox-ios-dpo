//
//  GenderView.swift
//  M2_Layout
//
//  Created by Николай Ногин on 14.11.2022.
//

import Foundation


import SwiftUI

struct GenderView: View {

    @State private var selectedGender: Gender = .man
    
    enum Gender: String, CaseIterable, Identifiable {
        case man, women
        var id: Self { self }
    }
    
    var body: some View {
        NavigationView {
            List {
                
            }
        }
    }
}

struct GenderView_Previews: PreviewProvider {
    static var previews: some View {
        GenderView()
    }
}
