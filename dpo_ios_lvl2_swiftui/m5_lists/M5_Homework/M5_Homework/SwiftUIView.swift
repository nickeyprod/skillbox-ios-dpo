import SwiftUI

struct SwiftUIView: View {
    
    @State var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            StackTabView().tabItem {
                Image(systemName: "tray.2")
                Text("Stack")
            }.tag(1)
            
            GridTabView().tabItem {
                Image(systemName: "calendar")
                Text("Grid")
            }.tag(2)
            
            ListTabView().tabItem {
                Image(systemName: "list.bullet.rectangle.portrait")
                Text("List")
            }.tag(3)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
