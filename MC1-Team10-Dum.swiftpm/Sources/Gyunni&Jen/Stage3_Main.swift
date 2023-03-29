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
    
    var body: some View {
        ZStack {
            Image("Stage3Bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
            Group {
                HStack {
                    Image("GQ")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                        .padding(.trailing, 100)
                    Image("GA")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                }
                    Image("MC1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 180)
            }
            .rotationEffect(animationFlag ? .degrees(0) : .degrees(3))
            .animation(.linear.repeatCount(5).speed(5), value: animationFlag)
            
            VStack {
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
                HStack{
                    Button {
                        currentHP -= 100
                        ultimateCount += 1
                        if ultimateCount >= 5 {
                            isUltimateOn.toggle()
                        }
                        animationFlag.toggle()
                    } label: {
                        Image("funnyPT")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                    }
                    
                    VStack {
                        Image("activated")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                            .opacity(ultimateCount < 5 ? 0 : 1.0)
                        
                        Button {
                            currentHP -= 200
                            ultimateCount = 0
                            isUltimateOn.toggle()
                            animationFlag.toggle()
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

                    }
                    .animation(.default, value: isUltimateOn)
                                        
                    Button {
                        currentHP -= 150
                    } label: {
                        Image("idea")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250)
                    }

                }
                
            }
            .padding(.top, 50)
            .padding(.bottom, 150)
            
            
        }
    }
}


struct Stage3_Main_Previews: PreviewProvider {
    static var previews: some View {
        Stage3_Main()
    }
}
