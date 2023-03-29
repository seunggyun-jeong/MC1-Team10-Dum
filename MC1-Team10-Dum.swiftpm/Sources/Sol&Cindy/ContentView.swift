import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("stage2_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
            HStack {
                NavigationLink(destination: Stage1_Main()) {
                    Image("first_stage_name")
                }
                
                NavigationLink(destination: Stage2_Main()) {
                    Image("second_stage_name")
                }

                NavigationLink(destination: Stage3_Main()) {
                    Image("third_stage_name")
                }
            }
        }

    }
}
