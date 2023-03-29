//
//  SwiftUIView.swift
//  
//
//  Created by Lee Juwon on 2023/03/29.
//

import SwiftUI




struct LeafView: View {
    
   
    var removal: (() -> Void)? = nil
    
    @State private var isDragging = false
    @State private var position=CGSize.zero
    
    var body: some View {
        Image("leafRight")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(.degrees(Double(position.width / 5)))
            .offset(x: position.width * 5, y: 0)
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

struct LeafView_Previews: PreviewProvider {
    static var previews: some View {
        LeafView()
    }
}
