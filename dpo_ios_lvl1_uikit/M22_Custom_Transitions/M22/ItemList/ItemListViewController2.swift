//
//  ItemListViewController2.swift
//  M22
//
//  Created by Николай Ногин on 09.09.2022.
//

import UIKit

final class ItemListViewController2: UIViewController {
    private let viewModel: ItemListViewModel2

    init(viewModel: ItemListViewModel2) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "New Transition"

        let itemButton = UIButton(title: "Open new Screen!!!", target: self, selector: #selector(onOpenScreenButton))
        
        let vStack = UIStackView(arrangedSubviews: [itemButton])
        addStackView(vStack: vStack)
    }

    @objc
    private func onOpenScreenButton() {
        viewModel.openNewScreen()
    }
}
