import SwiftUI

struct MainView: View {
    
    @Binding var tabSelection: Int
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Main Screen")
                    .font(.largeTitle)
                    .padding()
                
                    .navigationTitle("Main")
                
                Button("На вкладку Логин") {
                    tabSelection = 2
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(tabSelection: .constant(1))
    }
}
