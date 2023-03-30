import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
            HStack {
                NavigationLink(destination: Stage1_Main()) {
                    Image("first_stage_name")
                        .frame(width: 375)
                }
                
                NavigationLink(destination: Stage2_Main()) {
                    Image("second_stage_name")
                        .frame(width: 375)
                }

                NavigationLink(destination: Stage3_Main()) {
                    Image("third_stage_name")
                        .frame(width: 375)
                }
            }
        }

    }
}
