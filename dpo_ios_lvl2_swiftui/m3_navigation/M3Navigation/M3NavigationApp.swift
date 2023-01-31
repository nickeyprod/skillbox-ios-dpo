import SwiftUI

@main
struct M3NavigationApp: App {
    @State private var showLoginModally = false
    @State private var tabSelection = 1
    
    var body: some Scene {
        WindowGroup {
            GeneralTabView(
                router: MainRouter(showLoginModally: $showLoginModally, tabSelection: $tabSelection),
                tabSelection: $tabSelection,
                showLoginModally: $showLoginModally
            )
        }
    }
}
