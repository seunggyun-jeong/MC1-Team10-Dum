import SwiftUI

struct ContentView: View {
    @StateObject var SIClass: StageInformationClass = StageInformationClass()
    
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
            HStack {
                NavigationLink(destination: Stage1_Main(SIClass: SIClass)) {
                    Image("first_stage_name")
                        .frame(width: 375)
                }
                
                NavigationLink(destination: Stage2_Main(SIClass: SIClass)) {
                    Image("second_stage_name")
                        .frame(width: 375)
                }

                NavigationLink(destination: Stage3_Main(SIClass: SIClass)) {
                    Image("third_stage_name")
                        .frame(width: 375)
                }
            }
        }
        .navigationBarHidden(true)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
