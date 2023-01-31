//
//  NewScreenViewController.swift
//  M22
//
//  Created by Николай Ногин on 09.09.2022.
//

import UIKit

final class NewScreenViewController: UIViewController {
    private let viewModel: NewScreenModel
    
    init(viewModel: NewScreenModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "New Screen!!!"
        
        let dismissButton = UIButton(title: "Dismiss", target: self, selector: #selector(onDismissButton))
        
        let vStack = UIStackView(arrangedSubviews: [dismissButton])
        addStackView(vStack: vStack)
    }
    
    @objc
    private func onDismissButton() {
        viewModel.dismiss()
    }
    
    @objc
    private func onItemButton() {
        viewModel.openItem()
    }
    
}

