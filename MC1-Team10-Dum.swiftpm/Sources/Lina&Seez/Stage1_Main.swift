//
//  Stage1_Main.swift
//  
//
//  Created by 정승균 on 2023/03/28.
//

import SwiftUI



struct Stage1_Main: View {
    
    

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
            
            
            GeometryReader { proxy in
                    ForEach(0...5, id:\.self) { index in
                    LeafView(index: index, offset: logicalFunction(size: proxy.size))
                }
            }
        }
    }
    
    func logicalFunction(size: CGSize) -> CGSize {
            
            // Do your works here!
            
            let width: CGFloat = CGFloat.random(in: 0.0...size.width)
            let height: CGFloat = CGFloat.random(in: 0.0...size.height)
            
            return CGSize(width: width, height: height)
            
        }
    /*
    func removeLeaf(at index: Int) {
        leaves.remove(at: index)
    }
     */
}
