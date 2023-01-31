//
//  ViewController.swift
//  M20
//
//  Created by Николай Ногин on 19.08.2022.
//

import UIKit
import CoreData

enum Keys {
    static let sortingAsceding = "true"
}

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    private let container = NSPersistentContainer(name: "Model")
    private lazy var fetchedResultsController: NSFetchedResultsController<Artist> = {
  
        let fetchRequest: NSFetchRequest<Artist> = Artist.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "lastName", ascending: UserDefaults.standard.bool(forKey: Keys.sortingAsceding))
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    @IBOutlet weak var sortingControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        container.loadPersistentStores { (store, error) in
            guard error == nil else {
                print("Couldn't load persistent store")
                print("\(error!): \(error!.localizedDescription)")
                return
            }
            
            do {
                try self.fetchedResultsController.performFetch()
                self.sortingControl.selectedSegmentIndex =  UserDefaults.standard.bool(forKey: Keys.sortingAsceding) ? 0 : 1
            } catch {
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "fromTableToAddArtist" {
            let secondVC = segue.destination as? EditViewController
            
            let newArtist = Artist(entity: NSEntityDescription.entity(forEntityName: "Artist", in: container.viewContext)!, insertInto: nil)
            
            secondVC?.artistModel = newArtist
            secondVC?.container = container
        }
    }
    
    @IBAction func sortingChanged(_ sender: Any) {
        switch sortingControl.selectedSegmentIndex {
        case 0:
            fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: true)]
            try? fetchedResultsController.performFetch()
            UserDefaults.standard.set(true, forKey: Keys.sortingAsceding)
            tableView.reloadData()
        case 1 :
            fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "lastName", ascending: false)]
            try? fetchedResultsController.performFetch()
            UserDefaults.standard.set(false, forKey: Keys.sortingAsceding)
            tableView.reloadData()
        default:
            break
        }
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Artists"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let artist = fetchedResultsController.object(at: indexPath)
        let artistName = artist.name
        let artistLastName = artist.lastName
        cell.textLabel?.text = "\(artistName ?? "") \(artistLastName ?? "")"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let artist = fetchedResultsController.object(at: indexPath)
            container.viewContext.delete(artist)
            try? container.viewContext.save()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let artist = fetchedResultsController.object(at: indexPath)
        if let secondVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditViewController") as? EditViewController {
            secondVC.artistModel = artist
            secondVC.container = container
            secondVC.edit = true
            navigationController?.pushViewController(secondVC, animated: true)
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                let artist = fetchedResultsController.object(at: indexPath)
                let cell = tableView.cellForRow(at: indexPath)
                let artistName = artist.name ?? "Unknown"
                let artistLastName = artist.lastName ?? "Unknown"
                cell!.textLabel?.text = "\(artistName) \(artistLastName)"
            }
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            return
        }
    }

}
