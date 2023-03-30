import SwiftUI

struct ContentView: View {
    @StateObject var SIClass: StageInformationClass = StageInformationClass()
    
    var body: some View {
        ZStack {
            Image("stage2_background")
                .resizable()
                .aspectRatio(contentMode: .fill)
            HStack {
                NavigationLink(destination: Stage1_Main(SIClass: SIClass)) {
                    Image("first_stage_name")
                }
                
                NavigationLink(destination: Stage2_Main()) {
                    Image("second_stage_name")
                }

                NavigationLink(destination: Stage3_Main(SIClass: SIClass)) {
                    Image("third_stage_name")
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
