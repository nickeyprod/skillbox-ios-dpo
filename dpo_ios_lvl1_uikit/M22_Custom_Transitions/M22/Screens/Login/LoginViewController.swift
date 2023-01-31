import UIKit

final class LoginViewController: UIViewController {
    private let viewModel: LoginViewModel

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Login"
        
        let dismissButton = UIButton(title: "Dismiss", target: self, selector: #selector(onDismissButton))
        
        let itemButton = UIButton(title: "Some Item", target: self, selector: #selector(onItemButton))

      let vStack = UIStackView(arrangedSubviews: [dismissButton, itemButton])
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

