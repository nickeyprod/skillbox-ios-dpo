//
//  MyTeamVC.swift
//  Monster Track
//
//  Created by Николай Ногин on 15.12.2022.
//

import UIKit

class MyTeamVC: UIViewController {
    
    weak var viewModel: ViewModel?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set all delegates
        tableView.delegate = self
        tableView.dataSource = self
        navigationBar.delegate = self
        
        // transparent navigation bar
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

        // separator between cells line full width
        tableView.separatorInset = .zero
        
        // set beautiful background image for table view
        tableView.backgroundView = UIImageView(image: UIImage(named: "my-team-back"))
        
        // set cells to start 50px from top of the screen, from under navigation bar
        tableView.contentInset = UIEdgeInsets(top: 66, left: 0, bottom: 0, right: 0)
        
        if let safeModel = viewModel {
            // show 'no mosters catched' message view if no catched
            if safeModel.catchedMonsters.isEmpty {
                presentNoMonstersView()
            }
        }
    
    }
    
    // creates and presents view with required message
    private func presentNoMonstersView() {
        let emptyView = UIView()
        let noMonstersLabel = UILabel()
        
        noMonstersLabel.text = "Вы еще не поймали монстров в свою команду"
        noMonstersLabel.textColor = UIColor(named: Constants.Colors.titleColor)
        
        let backgroundImage = UIImage(named: "my-team-back")
        let imageView = UIImageView(image: backgroundImage)
        
        emptyView.addSubview(imageView)
        emptyView.addSubview(noMonstersLabel)
        
        // set 'no monsters catched' message view as background
        tableView.backgroundView = emptyView
        
        // setup constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        noMonstersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        noMonstersLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        noMonstersLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        noMonstersLabel.leftAnchor.constraint(equalTo: tableView.leftAnchor, constant: 20).isActive = true
        noMonstersLabel.rightAnchor.constraint(equalTo: tableView.rightAnchor, constant: -20).isActive = true
        noMonstersLabel.numberOfLines = 0
        noMonstersLabel.textAlignment = .justified
        imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: tableView.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageView.contentMode = .scaleToFill
    }
    
}

extension MyTeamVC: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension MyTeamVC: UITableViewDelegate {}

extension MyTeamVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let safeModel = viewModel {
            return safeModel.catchedMonsters.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let safeModel = viewModel {
            if let safeMonster = safeModel.catchedMonsters[indexPath.row] {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as? CustomCell {
                    cell.monsterNameLabel.text = safeMonster.name
                    cell.monsterLevelLabel.text = "Уровень \(safeMonster.level ?? 0)"
                    cell.monsterImage.image = UIImage(named: safeMonster.name.lowercased())
                    cell.backgroundColor = UIColor.clear
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
          viewModel?.catchedMonsters.remove(at: indexPath.row)
          viewModel?.cacheGameState()
          tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
}
