//
//  ViewController.swift
//  M20_Homework
//
//  Created by Maxim Nikolaev on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {

    
    private var numCatched = 0
    private let allFish = [
        Fish(imageView: UIImageView(image: UIImage(named: "fish"))),
        Fish(imageView: UIImageView(image: UIImage(named: "fish"))),
        Fish(imageView: UIImageView(image: UIImage(named: "fish"))),
        Fish(imageView: UIImageView(image: UIImage(named: "fish"))),
        Fish(imageView: UIImageView(image: UIImage(named: "fish"))),
    ]
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Catched: 0"
        textLabel.font = UIFont.boldSystemFont(ofSize: 26.0)
        textLabel.textColor = .white
        return textLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(tap)
        
        let backImage = UIImage(named: "ocean") ?? UIImage()
        view.backgroundColor = UIColor(patternImage: backImage)
        
        addTextLabel()
        
        addFish()
        animateFish()
        
    }
    
    private func addTextLabel() {
        
        view.addSubview(textLabel)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
    }
    
    private func addFish() {
        for fish in allFish {
        
            fish.imageView.frame = CGRect(x: 150, y: 150, width: 150, height: 150)
            fish.imageView.center = CGPoint(x: Int.random(in: 60...350), y:  Int.random(in: 60...800))
            fish.imageView.contentMode = .scaleAspectFit
            view.addSubview(fish.imageView)
        }
    }
    
    private func animateFish() {
        for fish in allFish {
            fish.isMoving = true
            move(fish: fish)
        }
    }
    
    private func restart() {
        print("Restart Game!")
        for fish in allFish {
            fish.isCatched = false
            fish.imageView.layer.removeAllAnimations()
            fish.imageView.center = CGPoint(x: Int.random(in: 60...350), y:  Int.random(in: 60...800))
            if !fish.isMoving { fish.isMoving = true; move(fish: fish)}
        }
        numCatched = 0
        textLabel.text = "Catched: \(numCatched)"
    }
    
    private func move(fish: Fish) {
        if fish.isCatched { return }
        UIView.animate(
            withDuration: 1.0,
            delay: 1.0,
            options: [.curveEaseInOut , .allowUserInteraction],
            animations: {
                fish.imageView.center = CGPoint(x: Int.random(in: 60...350), y:  Int.random(in: 60...800))
         }, completion: { finished in
            self.move(fish: fish)
         })
    }

    @objc func didTap(_ gesture: UITapGestureRecognizer) {
        for fish in allFish {
            if (fish.isCatched) { continue }
            let tapLocation = gesture.location(in: fish.imageView.superview)
            if (fish.imageView.layer.presentation()?.frame.contains(tapLocation))! {
                numCatched += 1
                fish.isCatched = true
                fish.isMoving = false
                textLabel.text = "Catched: \(numCatched)"
                fishCatchedAnimation(fishView: fish.imageView)
            }
        }
        
    }
    
    func fishCatchedAnimation(fishView: UIImageView) {
        UIView.animate(withDuration: 0.28, delay: 0, options: [.curveEaseInOut], animations: {
            fishView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }) { ended in
            fishView.center = CGPoint(x: -500, y: 0)
            fishView.transform = CGAffineTransform(scaleX: 1, y: 1)
            if self.numCatched == self.allFish.count {
                print("Game has Ended")
                return self.restart()
            }
        }
    }
    
    
}

