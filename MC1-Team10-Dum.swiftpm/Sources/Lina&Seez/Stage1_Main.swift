//
//  Stage1_Main.swift
//  
//
//  Created by 정승균 on 2023/03/28.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}

struct Stage1_Main: View {
    
    
    @State private var leaves = Array<Leaf>(repeating: Leaf.example, count:10)

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
                ForEach(0..<leaves.count, id:\.self){
                    index in
                    LeafView(leaf:leaves[index]){
                        withAnimation{removeLeaf(at: index)
                        }
                    }
                    .stacked(at:index, in:leaves.count)
                }
            }
        }
    }
    
    func removeLeaf(at index: Int) {
        leaves.remove(at: index)
    }
}
