//
//  ViewController.swift
//  GitHubReposExplorer
//
//  Created by Николай Ногин on 04.12.2022.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var repoNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func searchRepoBtnClicked(_ sender: Any) {
        if let orgName = repoNameTextField.text, repoNameTextField.text != "" {
            loadingIndicator(isActive: true)
            return viewModel.orgNameText = orgName
        }
        loadingIndicator(isActive: false)
        let alert = UIAlertController(title: "Введите название", message: "Поле ''название организации'' пусто, невозможно произвести поиск. Введите название и попробуйте снова.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel))
        return self.present(alert, animated: true, completion: nil)
    }
    
    private var viewModel = ViewModel()
    
    private var store: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator(isActive: false)
        setBindings()
    }
    
    private func setBindings() {
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel.$orgsList
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink { val in
                self.loadingIndicator(isActive: false)
                self.tableView.reloadData()
            }.store(in: &store)
        
        viewModel.$error
            .receive(on: RunLoop.main)
            .dropFirst()
            .sink {
                var message: String = String(describing: $0)
                switch $0 {
                case .sessionError(error: let err):
                    switch err {
                    case DataLoadError.repositoryNotExists:
                        message = "Организации с такими именем не найдено."
                    default:
                        return                    }
                default:
                    return
                }
    
                self.loadingIndicator(isActive: false)
                let alert = UIAlertController(title: "Ошибка!", message: "\(message)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel))
                self.present(alert, animated: true, completion: nil)
            }.store(in: &store)
        
    }

    private func loadingIndicator(isActive loading: Bool) {
        if loading  {
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimating()
        }
    }

}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orgsList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Found repos: \(viewModel.orgsList.count)"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = .black
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        header.textLabel?.textColor = .white
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myIdentifierCell", for: indexPath)
        cell.textLabel?.text = viewModel.orgsList[indexPath.row]?.name
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
