//
//  SwiftUIView.swift
//  
//
//  Created by Lee Juwon on 2023/03/29.
//

import SwiftUI


struct LeafRightView: View {
    
    let index: Int
    let offset: CGSize
   
    var removal: (() -> Void)? = nil
    
    @State private var isDragging = false
    @State private var position=CGSize.zero
    
    var body: some View {
        Image("leafRight")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(.degrees(Double(position.width / 5)))
            .offset(offset)
            .opacity(2 - Double(abs(position.width / 50)))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        position = value.translation
                        isDragging = true
                    }
                    .onEnded{ _ in
                        if abs(position.width) > 100 {
                            removal?()
                        } else {
                            position = .zero
                        }
                        isDragging = false
                    }
            )
    }
}


struct LeafLeftView: View {
    
    let index: Int
    let offset: CGSize
   
    var removal: (() -> Void)? = nil
    
    @State private var isDragging = false
    @State private var position=CGSize.zero
    
    var body: some View {
        Image("leafLeft")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(.degrees(Double(position.width / 5)))
            .offset(offset)
            .opacity(2 - Double(abs(position.width / 50)))
            .gesture(
                DragGesture()
                    .onChanged { value in
                        position = value.translation
                        isDragging = true
                    }
                    .onEnded{ _ in
                        if abs(position.width) > 100 {
                            removal?()
                        } else {
                            position = .zero
                        }
                        isDragging = false
                    }
            )
    }
}


