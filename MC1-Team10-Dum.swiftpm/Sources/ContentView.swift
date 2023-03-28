import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            
            NavigationLink(destination: Stage1_Main()) {
                Text("리나&시즈")
            }
            
            NavigationLink(destination: Stage2_Main()) {
                Text("솔&신디")
            }

            NavigationLink(destination: Stage3_Main()) {
                Text("규니&젠")
            }
        }
    }
}
