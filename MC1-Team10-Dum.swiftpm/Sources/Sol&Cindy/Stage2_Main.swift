//
//  Stage2_Main.swift
//
//
//  Created by 정승균 on 2023/03/28.
//

import SwiftUI

struct Stage2_Main: View {
    
    @StateObject var SIClass: StageInformationClass
    
    @State private var monsterImageName: String = "stage2_iceberg"
    
    
    @State private var press = false
    @State private var isAnimating = false
    @State private var decibel:Double = 0
    @State private var monsterCount: Int = 5
    @State private var monsterAttack: Bool = false
    @State private var endFlag = false
    
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
                    .isHidden(endFlag)
                
                Image(monsterImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: endFlag ? 0: 929)
                    .offset(x: self.isAnimating ? -10 : 10, y: self.isAnimating ? -10 : 10)
                    .animation(isAttackAnimation(isAnimation: isAnimating), value: isAnimating)
                    .rotationEffect(.degrees(endFlag ? 1440: 0))
                    .animation(.linear(duration: 3), value: endFlag)
                    
                Image("stage2_say")
                    .resizable()
                    .scaledToFit()
                    .frame(width:300)
                    .offset(x:-400,y:-160)
                    .isHidden(endFlag)
                
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
                                
                                if self.decibel > 50 {
                                    isAnimating = true
                                }
                                
                                if self.decibel > 100 {
                                    monsterAttack = true
                                    if monsterCount == 3 {
                                        monsterImageName = "stage2_iceberg_attack"
                                    }
                                    isAnimating = false
                                    return
                                }
                            }
                        })
                        .onEnded( { _ in
                            recorder.stopRecording()
                            if monsterAttack {
                                monsterCount -= 1
                                monsterAttack = false
                            }
                            if monsterCount == 1 {
                                endFlag = true
                            }
                        })
                )
            }
            StageClearView(SIClass : SIClass, deadFlag: $endFlag, mentorImageName: "DORA 1", mentorName: "DORA", mentorSpeak: "8시간 회의 괴물을 물리쳤군! 수고했어! CBL이 잘 진행되기 위해서는 팀원들과 휴식시간을 가지며 아이스 브레이킹 하는 것도 중요하지!!")
            .opacity(endFlag ? 0.8 : 0.0)
            .animation(.linear(duration: 3), value: endFlag)
        }
    }
    func isAttackAnimation(isAnimation: Bool) -> Animation {
        return isAnimation ? Animation.easeInOut(duration: 0.3).repeatForever(autoreverses: true) : Animation.easeIn(duration: 0.1).repeatCount(4)
    }
}

struct Stage2_Main_Previews: PreviewProvider {
    static var previews: some View {
        Stage2_Main(SIClass: StageInformationClass())
    }
}
