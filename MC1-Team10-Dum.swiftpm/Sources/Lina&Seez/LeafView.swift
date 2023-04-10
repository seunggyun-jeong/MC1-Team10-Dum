//
//  SwiftUIView.swift
//  
//
//  Created by Lee Juwon on 2023/03/29.
//

import SwiftUI


struct LeafView: View {
    
    let index: Int
    let offset: CGSize
    let player: AudioPlayer = AudioPlayer()
    let imageDirection: String
    
//    var removal: (() -> Void)? = nil
    
    @State private var isDragging = false
    @State private var position=CGSize.zero
    @State private var isLeaf = false
    
    @StateObject var leafVM:LeafViewModel

    
    var body: some View {
        Image(imageDirection)
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
//                            removal?()
                            isLeaf = true
                            leafVM.removeLeaf()
                            player.audioPlay(name: "leaf", numberOfLoops: 0)
                            //print("현재 이파리 개수 는?? ---> \(leafVM.countLeaf)")
                        } else {
                            position = .zero
                        }
                        isDragging = false
                    }
            )
            .isHidden(isLeaf)
    }
}


