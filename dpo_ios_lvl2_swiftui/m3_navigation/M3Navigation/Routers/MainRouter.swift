import SwiftUI

enum MainRoute {
    case loginView
    case catalogView
    case mainView
}

struct MainRouter: Router {
    typealias Route = MainRoute
    var usingNavigation = true
    
    @Binding var showLoginModally: Bool
    @Binding var tabSelection: Int
    
    func viewFor<T>(route: MainRoute, content: () -> T) -> AnyView where T : View {
        switch route {
            
        case .mainView:
            if usingNavigation {
                return AnyView(MainView(tabSelection: $tabSelection))
            } else {
                return AnyView(Button(action: {}) {
                    content()
                })
            }
        case .loginView:
            if usingNavigation {
                return AnyView(LoginView(showLoginModally: $showLoginModally))
            } else {
                return AnyView(Button(action: { }) {
                    content()
                })
            }
        case .catalogView:
            if usingNavigation {
                return AnyView(CatalogView(showLoginModally: $showLoginModally)) 
            } else {
                return AnyView(Button(action: {}) {
                    content()
                })
            }
        }
    }
}

