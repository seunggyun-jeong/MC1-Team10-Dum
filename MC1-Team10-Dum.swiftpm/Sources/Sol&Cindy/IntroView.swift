//
//  SwiftUIView.swift
//  
//
//  Created by apple on 2023/03/29.
//

import SwiftUI

struct IntroView: View {
    
    let backgroundEffectOffsetY: [CGFloat] = [100, 0, 100, 100, 100, 100]
    let planetFrameWidth: [CGFloat] = [400, 500, 1000, 1000, 1000, 1000]
    let planetOffsetY: [CGFloat] = [-100, 15, 500, 500, 500, 500]
    
    let titleFirstString: [CGFloat] = [-500, 0, 0, 0, 0, 0]
    let titleSecondString: [CGFloat] = [-200, 0, 0, 0, 0, 0]
    let titleThirdString: [CGFloat] = [-80, 0, 0, 0, 0, 0]
    let titleFourthString: [CGFloat] = [-170, 0, 0, 0, 0, 0]

    private var buttonText: [String] = ["", "- start -", "- Next -", "- Next -", "- Next -", "- Next -"]
    private var printText: [String] = ["", "", "3029년, 황금의 행성 '덤도라도'", "이곳에 엄청난 개발자로 성장할 수 있는 '덤덤물약'이 있다고 하는데...", "", "덤나라 용사가 최고의 개발자로 성장하기 위해 물약을 찾으러 모험을 떠난다!!"]
    
    @State private var pageIndex: Int = 0
    @State private var startFlag: Bool = false
    @State private var textFlag: Bool = false
    var body: some View {
        ZStack {
            Image("intro_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
            
            Image("intro_background_effect")
                .resizable()
                .aspectRatio(contentMode: .fill)
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
                Button(action: {
                    pageIndex += 1
                    if startFlag==false {
                        startFlag = true
                    }
                }) {
                    Text("\(buttonText[pageIndex])")
                        .foregroundColor(.white)
                        .bold()
                        .font(.system(size: 30))
                        .animation(.linear(duration: 2), value: pageIndex)
                }
            }
            .offset(y:300)
            
            Group {
                Text("\(printText[pageIndex])")
                    .font(.system(size: 30))
                    .bold()
                    .foregroundColor(.white)
                    .animation(.easeIn(duration: 1), value: pageIndex)
            }
        }
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


struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
