import UIKit

final class ItemListViewController: UIViewController {
    private let viewModel: ItemListViewModel

    init(viewModel: ItemListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "ItemList"

        let loginButton = UIButton(title: "Login", target: self, selector: #selector(onLoginButton))
        let itemButton = UIButton(title: "Open a Product", target: self, selector: #selector(onItemButton))
        
        let vStack = UIStackView(arrangedSubviews: [loginButton, itemButton])
        addStackView(vStack: vStack)
    }

    @objc
    private func onItemButton() {
        viewModel.openItem()
    }

    @objc
    private func onLoginButton() {
        viewModel.openLogin()
    }
}
