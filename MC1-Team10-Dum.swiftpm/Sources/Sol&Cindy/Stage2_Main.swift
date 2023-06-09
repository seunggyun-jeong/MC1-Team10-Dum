//
//  Stage2_Main.swift
//
//
//  Created by 정승균 on 2023/03/28.
//

import SwiftUI

struct Stage2_Main: View {
    let player: AudioPlayer = AudioPlayer()
    
    @StateObject var SIClass: StageInformationClass
    
    @State private var monsterImageName: String = "stage2_iceberg"
    
    
    @State private var press = false
    @State private var isAnimating = false
    @State private var decibel:Double = 0
    @State private var monsterCount: Int = 5
    @State private var monsterAttack: Bool = false
    @State private var endFlag = false
    @State private var isPush = false
    
    @State private var timer: Timer?
    @ObservedObject var recorder = Recorder()
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
            Image("stage2_cloud")
                .resizable()
                .aspectRatio(contentMode: .fill)
             
            ZStack {
                
                Image("stage2_name")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 392)
                    .offset(x: 100, y: -160)
                    .isHidden(endFlag)
                VStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundColor(Color.white)
//                            .border(.black)
                            .frame(width: 320, height: 34)
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 50)
                                .foregroundColor(Color.blue)
                            .frame(width: decibel, height: 20)
                            .animation(.spring(), value: decibel)
                        }
                        .frame(width: 310, height: 20, alignment: .leading)
                    }
                    .isHidden(endFlag)

                    Image(monsterImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: endFlag ? 0 : 929)
                        .offset(x: self.isAnimating ? -10 : 10, y: self.isAnimating ? -10 : 10)
                        .animation(isAttackAnimation(isAnimation: isAnimating), value: isAnimating)
                        .rotationEffect(.degrees(endFlag ? 1440: 0))
                        .animation(.linear(duration: 3), value: endFlag)
                        .onAppear {
                            player.audioPlay(name: "monster", numberOfLoops: 1)
                        }
                }
                    
                Image("stage2_say")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300)
                    .offset(x: -400, y: -160)
                    .isHidden(endFlag)
                
                Image("stage2_backdum")
                    .resizable()
                    .scaledToFit()
                    .offset(x: 0, y: 0)
                
                Button(action:{}) {
                    Image("stage2_button")
                }
                .offset(x: 0, y: 200)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ _ in
                            recorder.startRecording()
                            self.isPush = true
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
                            isPush = false
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
            Image("stage2_speak")
                .resizable()
                .scaledToFit()
                .frame(width: 340)
                .offset(x: 450, y: 180)
                .isHidden(!isPush)
            
            StageClearView(SIClass : SIClass, deadFlag: $endFlag, mentorImageName: "Dora 1", mentorName: "DORA", mentorSpeak: "8시간 회의 괴물을 물리쳤군! 수고했어!\nCBL이 잘 진행되기 위해서는 팀원들과 휴식시간을\n가지며 아이스 브레이킹 하는 것도 중요하지!!")
            .opacity(endFlag ? 0.8 : 0.0)
            .animation(.linear(duration: 3), value: endFlag)
            .onChange(of: endFlag) { _ in
                player.audioPlay(name: "mentor", numberOfLoops: 0)
            }
        }
        .navigationBarHidden(true)
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
