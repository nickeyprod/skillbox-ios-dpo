//
//  MainViewController.swift
//  PracticeCombine9
//
//  Created by Roman on 10.08.2022.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var originalImage: UIImage? = nil
    
    private var storage: Set<AnyCancellable> = []

    @IBAction func searchImageButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchController = storyboard.instantiateViewController(withIdentifier: "searchControllerID") as! SearchViewController
        
        searchController.imageSelected
            .handleEvents(receiveOutput: { [weak self] newImage in
                self?.didSelectImage(newImage)
            })
            .sink { _ in }
            .store(in: &storage)
        self.present(searchController, animated: true, completion: nil)
    }
    
    @IBAction func filterItButtonPressed(_ sender: Any) {
        guard let originalImage = self.originalImage else {
            return
        }
        getRandomFilters().map { filter in
            return originalImage.applyFilter(filter)
        }
        .assign(to: \.imageView!.image, on: self)
        .store(in: &storage)
    }
    
    
    @IBAction func shareItButtonPressed(_ sender: Any) {
        let imageToShare = [self.imageView.image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension MainViewController: SearchViewControllerDelegate {
    func didSelectImage(_ image: UIImage) {
        self.originalImage = image
        self.imageView.image = image
    }
}

