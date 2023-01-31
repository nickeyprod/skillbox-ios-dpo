//
//  SliderPanelView.swift
//  M7_Homework
//
//  Created by Николай Ногин on 28.11.2022.
//

import SwiftUI

struct SliderPanelView: View {
    
    @State var isDragging = false
    @State var offset = CGSize.zero
    @Binding var showView: Bool
    
    private let unlockWidth = 288.0
    
    var body: some View {
        
        let dragGesture = DragGesture()
            .onChanged { val in
                offset = CGSize(width: val.translation.width, height: 0)
                isDragging = true
                if offset.width >= unlockWidth {
                    offset = CGSize(width: unlockWidth, height: 0)
                    withAnimation {
                        showView = true
                    }
                }
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        ZStack {
            RoundedRectangle(cornerRadius: 60)
                .fill(.gray)
                .frame(width: 370, height: 80)
                .opacity(0.78)
            Text("Потяните для разбл-ки")
            HStack {
                Circle()
                    .fill(.white)
                    .frame(width: 80, height: 80)
                    .scaleEffect(isDragging ? 1.2 : 1)
                    .opacity(isDragging ? 0.8 : 1)
                    .offset(offset)
                    .gesture(dragGesture)
                Spacer()
            }
        }
        .padding(.leading, 80)
        .padding(.trailing, 80)
        
    }
}

