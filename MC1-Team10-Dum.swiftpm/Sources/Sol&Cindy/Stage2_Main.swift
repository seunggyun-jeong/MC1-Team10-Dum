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
    @State private var decibel:Double = 0
    @State private var monsterCount: Int = 5
    
    @State private var timer: Timer?
    @ObservedObject var recorder = Recorder()
    
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
                    .animation(Animation.easeInOut(duration:0.3).repeatForever(autoreverses: true), value: isAnimating)

                Image("stage2_say")
                    .resizable()
                    .scaledToFit()
                    .frame(width:300)
                    .offset(x:-400,y:-160)
                Image("stage2_backdum")
                    .resizable()
                    .scaledToFit()
                    .offset(x:0,y:220)
                
                Text(press ? "누르고 있습니다 \(monsterCount) \(decibel)" : "누르고 있지 않습니다 \(monsterCount) \(decibel)")
                
                Button(action:{}) {
                    Image("stage2_button")
                }
                .offset(x:0,y:200)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ _ in
                            recorder.startRecording()
                            self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                                self.decibel = recorder.updateDecibels()
                                
                                if self.decibel > 100 {
                                    isAnimating = true
                                }
                                
                                if self.decibel > 150 {
                                    monsterCount -= 1
                                    timer?.invalidate()
                                    recorder.stopRecording()
                                }
                            }
                        })
                        .onEnded( { _ in
                            isAnimating = false
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
