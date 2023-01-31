//
//  ItemListViewModel2.swift
//  M22
//
//  Created by Николай Ногин on 09.09.2022.
//

import Foundation

final class ItemListViewModel2 {
    typealias Routes = NewScreenRoute
    private let router: Routes

    init(router: Routes) {
        self.router = router
    }

    func openNewScreen() {
        router.openNewScreen()
    }

}
