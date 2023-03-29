//
//  Stage2_Main.swift
//  
//
//  Created by 정승균 on 2023/03/28.
//

import SwiftUI

struct Stage2_Main: View {
    @State private var press = false
    
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
                Text(press ? "누르고 있습니다" : "누르고 있지 않습니다")
                Button(action:{}) {
                    Image("stage2_button")
                }
                .offset(x:0,y:240)
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
