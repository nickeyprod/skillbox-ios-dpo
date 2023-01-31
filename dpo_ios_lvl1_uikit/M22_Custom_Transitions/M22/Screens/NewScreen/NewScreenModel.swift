//
//  NewScreenModel.swift
//  M22
//
//  Created by Николай Ногин on 09.09.2022.
//

import Foundation

final class NewScreenModel {
    typealias Routes = LoginRoute & Closable & ItemRoute
    private var router: Routes

    init(router: Routes) {
        self.router = router
    }

    func dismiss() {
        router.close()
    }
    
    func openItem() {
        router.openItem()
    }
}
