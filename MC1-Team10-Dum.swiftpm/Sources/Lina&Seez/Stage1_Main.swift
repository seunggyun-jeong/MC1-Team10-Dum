//
//  Stage1_Main.swift
//  
//
//  Created by 정승균 on 2023/03/28.
//

import SwiftUI


import SwiftUI

struct Stage1_Main: View {
    
    @State private var offset: CGSize = .zero
    
    
    var body: some View {
        
        let drag = DragGesture()
                    .onChanged { gesture in
                        offset=gesture.translation}
                    .onEnded {
                        //드래그 가로의 위치가 -100보다 작은 위치로 가면 실행
                        if $0.translation.width < -100 {
                            self.offset = .init(width: -1000, height: 0)
                        //드래그 가로의 위치가 100보다 커지면 실행
                        } else if $0.translation.width > 100 {
                            self.offset = .init(width: 1000, height: 0)
                        //아니면 원래 위치로 돌아감
                        } else {
                            self.offset = .zero
                        }
                    }
        
        
        return bodyView()
            
            
      
}
    
    struct bodyView :View{
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
                
                //leapView()
                   
            }
            }
        }
    }

/*
struct leapView : View{
    
    var body : some View{
        
       let right = Image("leapRight")
            .resizable()
            .aspectRatio(contentMode: .fit)

       let left =  Image("leapLeft")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
}
 */



/*
struct Stage1_Main: View {
    var body: some View {
        Text("리나 시즈 화이팅")
    }
}

struct Stage1_Main_Previews: PreviewProvider {
    static var previews: some View {
        Stage1_Main()
    }
}
*/
