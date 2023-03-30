//
//  SwiftUIView.swift
//  
//
//  Created by 정승균 on 2023/03/29.
//

import SwiftUI

struct OutroView: View {
    let backgroundEffectOffsetY: [CGFloat] = [100, 0, 100, 900]
    let planetFrameWidth: [CGFloat] = [400, 500, 1000]
    let planetOffsetY: [CGFloat] = [-100, 15, 500, 500]
    
    
    private var printText: [String] = ["", "당신은 모든 스테이지를 클리어 했습니다.", "이제, 드디어 덤도라도에 도착하였습니다.", "덤도라도에서 덤덤물약이 담겨있다는 보물상자를 찾았다!", "", "덤나라 용사가 최고의 개발자로 성장하기 위해 물약을 찾으러 모험을 떠난다!!", ""]
    private var boxImage: [String] = ["", "", "", "box_closed 1", "box_opened 1", "box_opened 1"]
    
    @State private var pageIndex: Int = 0
    @State private var startFlag: Bool = false
    @State private var endFlag: Bool = false
    @State private var imageViewFlag: Bool = false
    @State private var boxFlag: Bool = false
    @State private var shineFlag: Bool = false
    @State private var shineAnimateFlag: Bool = false
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            Image("intro_background_effect")
                .resizable()
                .offset(y: backgroundEffectOffsetY[min(3,pageIndex)])
                .animation(.spring(response: 2, dampingFraction: 0.5, blendDuration: 0), value: pageIndex)
                .onAppear {
                    pageIndex += 1
                }
            
            Image("intro_planet")
                .resizable()
                .scaledToFit()
                .frame(width: planetFrameWidth[min(2,pageIndex)])
                .offset(x: -70, y: planetOffsetY[min(3,pageIndex)])
                .animation(.spring(response: 2, dampingFraction: 0.5, blendDuration: 0), value: pageIndex)
                .animation(.linear(duration: 1), value: planetOffsetY[min(3,pageIndex)])
            ZStack {
                VStack {
                    Text("\(printText[pageIndex])")
                        .font(.system(size: 30))
                        .bold()
                        .foregroundColor(.white)
                        .animation(.easeIn(duration: 1), value: pageIndex)
                    
                    Image(boxImage[pageIndex])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500)
                        .isHidden(!boxFlag, remove: !boxFlag)
                        .offset(y: 60)
                }
                Image("shining_effect")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(shineAnimateFlag ? 0 : 360))
                    .animation(.linear.repeatForever().speed(0.1), value: shineAnimateFlag)
                    .opacity(shineFlag ? 1.0 : 0)
                    
            }

        }
        .onTapGesture {
            pageIndex += 1
            if startFlag==false {
                startFlag = true
            }
            if pageIndex > 5 {
                endFlag = true
                pageIndex = 0
            }
            if pageIndex > 2 {
                boxFlag = true
            }
            if pageIndex > 4 {
                shineFlag = true
                shineAnimateFlag = true
            }
        }
        .navigationBarHidden(true)
    }
}


extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

struct OutroView_Previews: PreviewProvider {
    static var previews: some View {
        OutroView()
    }
}
