//
//  Stage2_Main.swift
//
//
//  Created by 정승균 on 2023/03/28.
//

import SwiftUI

struct Stage2_Main: View {
    @State private var press = false
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Image("stage2_background")
                .resizable()
            Image("stage2_cloud")
                .resizable()
                .aspectRatio(contentMode: .fill)
             
            ZStack {
                Image("stage2_name")
                    .resizable()
                    .scaledToFit()
                    .frame(width:392)
                    .offset(x:100,y:-160)
                Image("stage2_iceberg")
                    .resizable()
                    .scaledToFit()
                    .frame(width:929)
                    .offset(x: self.isAnimating ? -10 : 10, y: self.isAnimating ? -10 : 10)
                    .animation(Animation.easeInOut(duration:0.3)
                        .repeatForever(autoreverses: true))
                        .onAppear {
                                    self.isAnimating = true
                                    }
                Image("stage2_say")
                    .resizable()
                    .scaledToFit()
                    .frame(width:300)
                    .offset(x:-400,y:-160)
                Text(press ? "누르고 있습니다" : "누르고 있지 않습니다")
                Image("stage2_backdum")
                    .resizable()
                    .scaledToFit()
                    .offset(x:0,y:220)
                Button(action:{}) {
                    Image("stage2_button")
                }
                .offset(x:0,y:200)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ _ in
                            self.press = true
                        })
                        .onEnded({ _ in
                            self.press = false
                        })
                )
            }
        }
    }
}

struct Stage2_Main_Previews: PreviewProvider {
    static var previews: some View {
        Stage2_Main()
    }
}
