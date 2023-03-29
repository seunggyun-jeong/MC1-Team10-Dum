//
//  Stage3_Main.swift
//  
//
//  Created by 정승균 on 2023/03/28.
//

import SwiftUI

struct Stage3_Main: View {
    
    @State private var currentHP = 1060.0
    @State private var animationFlag = false
    @State private var ultimateCount = 0
    @State private var isUltimateOn = false
    
    @State private var GQFlag: Bool = false
    @State private var GAFlag: Bool = false
    @State private var MCFlag: Bool = false
    @State private var deadFlag: Bool = false

    var body: some View {
        ZStack {
            // 배경화면
            Image("Stage3Bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            // 몬스터들
            Group {
                HStack {
                    Image("GQ_monster")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                        .padding(.trailing, 150)
                    Image("GA_monster")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
                }
                    Image("MC1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200)
            }
            .padding(.bottom, 200)
            .rotationEffect(animationFlag ? .degrees(0) : .degrees(3))
            .animation(.linear.repeatCount(5).speed(5), value: animationFlag)
            
            // 바닥에 용사들 모임
            VStack {
                Image("heros")
                    .resizable()
                    .padding(.bottom, 20)
            }
            
            // 적들의 공격 말풍선
            Group {
                // TODO: - GQ --> HP <= 700 일 때 --> GQ_attack --> HP += 100
                Image("question_attack")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .opacity(GQFlag ? 1.0 : 0)
                .padding(.trailing, 700)
                .animation(.linear(duration: 1), value: GQFlag)
            
                // TODO: - GA --> HP <= 500 일 때 --> GA_attack --> HP += 100
                Image("GA_attack")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .opacity(GAFlag ? 1.0 : 0)
                .padding(.leading, 700)
                .animation(.linear(duration: 1), value: GAFlag)

                
                // TODO: - MC1 --> HP <= 100 일 때 --> MC_attack --> HP += 500
                Image("fight_attack")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .opacity(MCFlag ? 1.0 : 0)
                .padding(.leading, 350)
                .padding(.bottom, 50)
                .animation(.linear(duration: 1), value: MCFlag)
            }
            .padding(.bottom, 400)
            
            VStack {
                // 체력바
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(Color.white)
                        .border(.black)
                        .frame(width: 1082, height: 34)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundColor(Color.red)
                        .frame(width: currentHP, height: 20)
                        .animation(.spring(), value: currentHP)
                    }
                    .frame(width: 1060, height: 20, alignment: .leading)
                }
                
                Spacer()
                
                // 히어로 공격 버튼s
                HStack (alignment: .top) {
                    // 재밌는 발표
                    Button {
                        attackMethod(damage: 200)
                        ultimateCount += 1
                        if ultimateCount == 5 {
                            isUltimateOn.toggle()
                        }
                    } label: {
                        Image("funnyPT")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                    }
                    
                    VStack {
                        // 솔의 발연기
                        Button {
                            attackMethod(damage: 700)
                            isUltimateOn.toggle()
                        } label: {
                            if !isUltimateOn {
                                Image("actSol_disable")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250)
                            }
                            else {
                                Image("actSol")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250)
                            }
                        }
                        .disabled(!isUltimateOn)
                        .rotationEffect(isUltimateOn ? Angle(degrees: 3) : Angle(degrees: 0))
                        Image("activated")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140)
                            .opacity(isUltimateOn ? 1.0 : 0)
                    }
                    .animation(isUltimateOn ? .linear.repeatForever() : .linear, value: isUltimateOn)
                    
                    // 아이디어 수렴과 발산
                    Button {
                        attackMethod(damage: 200)
                    } label: {
                        Image("idea")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                    }
                }
            }
            .padding(.top, 50)
            .padding(.bottom, 200)
            
            // 퀘스트 클리어 시 아웃트로
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                
                HStack(spacing: 30) {
                    VStack {
                        Image("GQ_monster")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        Text("Mentor. JUDY")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .bold()
                    }
                    
                    Text("어색함 괴물을 물리쳤군! 수고했어!\nCBL을 위해서 가장 필요한 스킬인 소통 능력이\n 잘 장착되었길 바란다!")
                        .foregroundColor(.white)
                        .font(.system(size: 30))
                        .bold()
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: OutroView()) {
                            Image("nextButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                        }
                        .disabled(!deadFlag)

                    }
                }
                .padding([.bottom, .trailing], 50)
            }
            .opacity(deadFlag ? 0.8 : 0.0)
        }
    }
    
    func attackMethod(damage: Double) {
        // width가 0보다 밑으로 내려가지 않게 예외 처리
        if (currentHP - damage) <= 0.0 {
            currentHP = 0
        } else {
            currentHP -= damage
        }
        animationFlag.toggle()
        
        if !GQFlag && currentHP <= 700 {
            GQFlag.toggle()
            currentHP += 300
        }
        
        if !GAFlag && currentHP <= 500 {
            GAFlag.toggle()
            currentHP += 300
        }
        
        if !MCFlag && currentHP <= 100 {
            MCFlag.toggle()
            currentHP += 500
        }
        
        if currentHP <= 0 {
            deadFlag = true
            print("으앙 주금")
        }
    }
}


struct Stage3_Main_Previews: PreviewProvider {
    static var previews: some View {
        Stage3_Main()
    }
}
