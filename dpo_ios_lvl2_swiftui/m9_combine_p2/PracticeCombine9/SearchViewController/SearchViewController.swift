//
//  SearchViewController.swift
//  PracticeCombine9
//
//  Created by Roman on 10.08.2022.
//

import Foundation
import UIKit
import Combine

class SearchViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorVIew: UIActivityIndicatorView!
    
    private var viewModel: ImagesViewModel = ImagesViewModel()
    
    let imageSelected = PassthroughSubject<UIImage, Never>()
    
    private var searchTimer: Timer? = nil
    
    private let itemsOnRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 24.0, left: 24.0, bottom: 24.0, right: 24.0)
    
    private var subscription: AnyCancellable? = nil
    
    private var storage: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setBindings()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.isHidden = true
        self.activityIndicatorVIew.isHidden = true
    }

    
    private func setBindings() {

        textField.textPublisher
            .assign(to: \.searchText , on: viewModel)
            .store(in: &storage)
        
        viewModel.$images
            .sink { _ in
                self.activityIndicatorVIew.isHidden = true
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }.store(in: &storage) 
        
        viewModel.$error
            .sink { error in
                self.collectionView.isHidden = true
                self.activityIndicatorVIew.isHidden = true
                
                let alert = UIAlertController(title: "Error", message: "\(String(describing: error))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true, completion: nil)
            }.store(in: &storage)
        
        viewModel.$searchStarted
            .sink(receiveValue: { searchStarted in
                if searchStarted {
                    print("started")
                    self.collectionView.isHidden = true
                    self.activityIndicatorVIew.isHidden = false
                }
            }).store(in: &storage)
    }
}

extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.images.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellReuseIdentifier", for: indexPath) as! SearchViewControllerCell
        cell.imageView.image = self.viewModel.images[indexPath.row]
        return cell
    }
    
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsOnRow + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = floor(availableWidth / itemsOnRow)
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return sectionInsets.left
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.row < self.viewModel.images.count else {
            return
        }
        imageSelected.send(self.viewModel.images[indexPath.row])
    }
}
