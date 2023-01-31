//
//  TabView.swift
//  M3Navigation
//
//  Created by Николай Ногин on 18.11.2022.
//

import SwiftUI

struct GeneralTabView<MainRouter: Router>: View where MainRouter.Route == MainRoute {
    
    let router: MainRouter
    
    @Binding var tabSelection: Int
    @Binding var showLoginModally: Bool
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                
                router.viewFor(route: .mainView) {
                    MainView(tabSelection: $tabSelection)
                }.tabItem {
                    Label("Main", systemImage: "list.dash")
                }.tag(1)

                router.viewFor(route: .loginView) {
                    LoginView(showLoginModally: $showLoginModally)
                }.tabItem {
                    Label("Login", systemImage: "square.and.pencil")
                }.tag(2)
                
                router.viewFor(route: .catalogView) {
                    CatalogView(showLoginModally: $showLoginModally)
                }.tabItem {
                    Label("Catalog", systemImage: "house")
                }.tag(3)
            }
        }
        
    }
}


struct GeneralTabView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTabView(
            router: MainRouter(showLoginModally: .constant(false), tabSelection: .constant(1)),
            tabSelection: .constant(1),
            showLoginModally: .constant(false)
        
        )
    }
}
