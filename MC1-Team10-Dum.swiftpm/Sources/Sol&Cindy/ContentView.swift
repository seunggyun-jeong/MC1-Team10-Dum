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
                    Image( SIClass.stageCounter >= 1 ? "second_stage_name" : "lock")
                        .frame(width: 375)
                }.disabled(SIClass.stageCounter < 1)

                NavigationLink(destination: Stage3_Main(SIClass: SIClass)) {
                    Image(SIClass.stageCounter >= 2 ? "third_stage_name" : "lock")
                        .frame(width: 375)
                }.disabled(SIClass.stageCounter < 2)
            }
            
           
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
