import SwiftUI

@main
struct MyApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                IntroView()
            }
            .navigationBarHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
    }
}
