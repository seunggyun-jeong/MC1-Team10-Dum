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
    
    let BgPlayer: AudioPlayer = AudioPlayer()
    private var printText: [String] = ["", "당신은 모든 스테이지를 클리어 했습니다.", "이제, 드디어 덤도라도에 도착하였습니다.", "덤도라도에서 덤덤물약이 담겨있다는 보물상자를 찾았다!", "", "알고보니 전설의 덤덤물약은 없었다고 한다...\n하지만 CBL과 협동심, 그리고 동료들을 얻었다.!!", ""]
    private var boxImage: [String] = ["", "", "", "box_closed 1", "box_opened 1", ""]
    
    @State private var pageIndex: Int = 0
    @State private var startFlag: Bool = false
    @State private var endFlag: Bool = false
    @State private var imageViewFlag: Bool = false
    @State private var boxFlag: Bool = false
    @State private var shineFlag: Bool = false
    @State private var shineAnimateFlag: Bool = false
    @State private var heroAnimateFlag: Bool = false
    @State private var rotation = 270.0
    
    var body: some View {
        ZStack {
            Image(pageIndex >= 5 ? "galaxy" : "background")
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
                    Text("\(printText[min(6,pageIndex)])")
                        .font(.system(size: 30))
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .animation(.easeIn(duration: 0.5), value: pageIndex)
                        .opacity(rotation >= 550 ? 0 : 1.0 )
                    
                    Image(boxImage[min(5,pageIndex)])
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500)
                        .isHidden(!boxFlag, remove: !boxFlag)
                        .offset(y: 60)
                }
                Image("shining_effect")
                    .resizable()
                    .scaledToFill()
                    .rotationEffect(.degrees(shineAnimateFlag ? 0 : 360))
                    .animation(.linear.repeatForever().speed(0.1), value: shineAnimateFlag)
                    .opacity(shineFlag ? 1.0 : 0)
                    .offset(y:60)

            }
            ZStack {
                if pageIndex >= 5  {
                    Image("heroOnPlanet")
                        .resizable()
                        .scaledToFit()
                        .offset(y: 350)
                        .rotationEffect(.degrees(rotation), anchor:.bottom)
                        .animation(.linear.speed(0.1), value:rotation)
                }
                Image("theEnd")
                    .resizable()
                    .scaledToFit()
                    .frame(width:400)
                    .opacity(rotation >= 550 ? 1.0 : 0)
                    .offset(y:-50)
                Slider(value: $rotation, in: 270...550, step: 10.0)
                    .opacity(pageIndex >= 5 ? 1.0 : 0)
                    .offset(y:200)
                    .frame(width: 400)
                Image("pushHeroGuide")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400)
                    .offset(y:280)
                    .opacity(pageIndex >= 5 ? 1.0 : 0)
            }
            
        }
        .onTapGesture {
            pageIndex += 1
            if startFlag==false {
                BgPlayer.audioPlay(name: "endBackground", numberOfLoops: -1)
                startFlag = true
            }
            if pageIndex > 8 {
                endFlag = true
                pageIndex = 0
            }
            if pageIndex > 2 {
                boxFlag = true
            }
            if pageIndex == 4 {
                shineFlag = true
                shineAnimateFlag = true
                BgPlayer.audioPlay(name: "boxendBackground", numberOfLoops: -1)
            }
            if pageIndex == 5 {
                shineFlag = false
                shineAnimateFlag = false
                heroAnimateFlag = true
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
