//
//  StageClearView.swift
//  
//
//  Created by 정승균 on 2023/03/30.
//

import SwiftUI

struct StageClearView: View {
    
    @StateObject var SIClass: StageInformationClass
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var deadFlag: Bool
    @State var mentorImageName: String
    @State var mentorName: String
    @State var mentorSpeak: String
    
    var body: some View {
        // 퀘스트 클리어 시 아웃트로
        ZStack {
            Rectangle()
                .foregroundColor(.black)
            
            VStack {
                Text("STAGE CLEAR")
                    .font(.system(size: 48))
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                
                HStack(spacing: 30) {
                    VStack {
                        Image(mentorImageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200)
                        Text("Mentor. \(mentorName)")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .bold()
                    }
                        Text(mentorSpeak)
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                            .bold()

                }
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if SIClass.stageCounter == 2 {
                        NavigationLink(destination: OutroView()) {
                            Image("nextButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                        }
                        .disabled(!deadFlag)
                    } else {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                            SIClass.compeleteStage()
                        } label: {
                            Image("nextButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                        }
                        .disabled(!deadFlag)

                    }


                }
            }
            .padding([.bottom, .trailing], 50)
        }
    }
}

struct StageClearView_Previews: PreviewProvider {
    static var previews: some View {
        StageClearView(SIClass: StageInformationClass(), deadFlag: .constant(false), mentorImageName: "GQ_monster", mentorName: "JUDY", mentorSpeak: "어색함 괴물을 물리쳤군! 수고했어!\nCBL을 위해서 가장 필요한 스킬인 소통 능력이\n 잘 장착되었길 바란다!")
    }
}
