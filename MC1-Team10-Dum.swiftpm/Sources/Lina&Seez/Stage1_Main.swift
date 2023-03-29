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
            
            
            LeafView()
        }
    }
    
    /*
    func removeLeaf(at index: Int) {
        leaves.remove(at: index)
    }
     */
}
