//
//  SwiftUIView.swift
//
//
//  Created by apple on 2023/03/29.
//

import SwiftUI
import AVFoundation

struct IntroView: View {
    
    let backgroundEffectOffsetY: [CGFloat] = [100, 0, 100, 900, 900, 900, 900]
    let planetFrameWidth: [CGFloat] = [400, 500, 1000, 1000, 1000, 1000, 1000]
    let planetOffsetY: [CGFloat] = [-100, 15, 500, 900, 900, 900, 900]
    
    let titleFirstString: [CGFloat] = [-500, 0, 0, 0, 0, 0, 0]
    let titleSecondString: [CGFloat] = [-200, 0, 0, 0, 0, 0, 0]
    let titleThirdString: [CGFloat] = [-80, 0, 0, 0, 0, 0, 0]
    let titleFourthString: [CGFloat] = [-170, 0, 0, 0, 0, 0, 0]
    
    let BgPlayer: AudioPlayer = AudioPlayer()
    let Player: AudioPlayer = AudioPlayer()
    
    private var printText: [String] = ["", "", "3313년, 황금의 행성 '덤도라도'", "이곳에 엄청난 개발자로 성장할 수 있는 '덤덤물약'이 있다고 하는데...", "", "덤나라 용사가 최고의 개발자로 성장하기 위해 물약을 찾으러 모험을 떠난다!!", ""]
    
    @State private var pageIndex: Int = 0
    @State private var startFlag: Bool = false
    @State private var endFlag: Bool = false
    @State private var imageViewFlag: Bool = false
    @State private var textFlag: Bool = false
    @State private var herodumbs: Bool = false
    
    var body: some View {
        
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .onAppear {
                    BgPlayer.audioPlay(name: "background", numberOfLoops: -1)
                }
            
            Image("intro_background_effect")
                .resizable()
                .offset(y: backgroundEffectOffsetY[pageIndex])
                .animation(.spring(response: 2, dampingFraction: 0.5, blendDuration: 0), value: pageIndex)
                .onAppear {
                    pageIndex += 1
                }
            
            Image("intro_planet")
                .resizable()
                .scaledToFit()
                .frame(width: planetFrameWidth[pageIndex])
                .offset(x: -70, y: planetOffsetY[pageIndex])
                .animation(.spring(response: 2, dampingFraction: 0.5, blendDuration: 0), value: pageIndex)
                .animation(.linear(duration: 1), value: planetOffsetY[pageIndex])
            
            HStack {
                Image("intro_title_first_text")
                    .offset(y: titleFirstString[pageIndex])
                    .animation(.spring(response: 2, dampingFraction: 0.5, blendDuration: 0), value: pageIndex)
                    .isHidden(startFlag, remove: startFlag)
                Image("intro_title_second_text")
                    .offset(y: titleSecondString[pageIndex])
                    .animation(.spring(response: 2, dampingFraction: 0.5, blendDuration: 0), value: pageIndex)
                    .isHidden(startFlag, remove: startFlag)
                Image("intro_title_third_text")
                    .offset(y: titleThirdString[pageIndex])
                    .animation(.spring(response: 2, dampingFraction: 0.5, blendDuration: 0), value: pageIndex)
                    .isHidden(startFlag, remove: startFlag)
                Image("intro_title_forth_text")
                    .offset(y: titleFourthString[pageIndex])
                    .animation(.spring(response: 2, dampingFraction: 0.5, blendDuration: 0), value: pageIndex)
                    .isHidden(startFlag, remove: startFlag)
            }
            
            Group {
                Text("\(printText[pageIndex])")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.white)
                    .animation(.easeIn(duration: 1), value: pageIndex)
                    .onChange(of: pageIndex) { _ in
                        if printText[pageIndex] != "" {
                            Player.audioPlay(name: "typing", numberOfLoops: 0)
                        }
                    }
            }
            
            Image("intro_dumbs")
                .offset(x: herodumbs ? 1200 : -1200)
                .animation(Animation.linear(duration:5), value: herodumbs)
            
            NavigationLink(destination: ContentView()) {
                Text("Start")
                    .bold()
                    .foregroundColor(.white)
                    .font(.system(size: 17))
            }
            .isHidden(!endFlag)
            .onChange(of: endFlag) { _ in
                BgPlayer.audioStop()
            }
        }
        .onTapGesture {
            pageIndex += 1
            if startFlag==false {
                startFlag = true
            }
            if pageIndex == 4 {
                herodumbs = true
                Player.audioPlay(name: "walking")
            }
            if pageIndex > 5 {
                endFlag = true
                pageIndex = 0
//                NavigationLink(destination: ContentView()) {
//                    EmptyView()
//                }
            }
        }
    }
}


struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

