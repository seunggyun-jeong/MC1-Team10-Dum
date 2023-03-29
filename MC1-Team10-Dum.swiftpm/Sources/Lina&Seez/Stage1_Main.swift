//
//  Stage1_Main.swift
//  
//
//  Created by 정승균 on 2023/03/28.
//

import SwiftUI

struct Stage1_Main: View {
    var removal: (() -> Void)? = nil
    
        
    @State private var isDragging = false
    @State private var position=CGSize.zero
    
    
    var body: some View{
        ZStack{
            Image("spaceAwkward")
                .resizable()
                .aspectRatio(contentMode: .fill)
                
            Image("monsterName")
                .resizable()
                .scaledToFit()
                .frame(width: 265)
                .offset(x:155, y:-110)
                    
                
            Image("roseMonster")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            
            ZStack{
                Image("leapRight")
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
    }
}
