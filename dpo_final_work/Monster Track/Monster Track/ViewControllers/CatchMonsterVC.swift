//
//  CatchMonsterVC.swift
//  Monster Track
//
//  Created by Николай Ногин on 20.12.2022.
//

import SwiftUI
import ARKit
import MapKit
import AVFoundation

class CatchMonsterVC: UIViewController, AVAudioPlayerDelegate {

    weak var viewModel: ViewModel?
    weak var mapView: MKMapView?
    
    
    var currMonsterAnnotation: MKAnnotation?
    var currMonsterName: String?
    
    var player: AVAudioPlayer?

    private var currMonsterLevel: Int?
    private var monsterNode: SCNNode?
    private var nameNode: SCNNode?
    private var levelNode: SCNNode?
    private var currChanceToCatch = Constants.CHANCE_OF_CATCH
    
    var surfaceDetected = false
    var timer: Timer?
    
    @IBOutlet weak var tryCatchBtn: UIButton!
    @IBOutlet weak var chanceOfCatchLabel: UILabel!
    @IBOutlet weak var searchForSurface: UILabel!
    
    @IBOutlet weak var lureButton: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    @IBAction func tryCatchButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.playSound(name: "menu_click")
            self.tryCatchMonster()
        }
    }
    @IBAction func useLureButtonPressed(_ sender: Any) {
        
        self.playSound(name: "menu_click")
        
        if let safeModel = viewModel {
            
            if safeModel.lureCount > 0 {
                safeModel.useLure = true
                viewModel?.lureCount -= 1
                // save that one lure used
                viewModel?.cacheGameState()
            } else {
                // invalidate timer if it already exists
                timer?.invalidate()
                timer = nil
                // run new timer
                timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(hideNoLureText), userInfo: nil, repeats: false)
                searchForSurface.isHidden = false
                searchForSurface.text = "У Вас нет приманок!"
            }
            
        }
    }
    
    @IBAction func backToMapBtnPressed(_ sender: Any) {
        
        self.playSound(name: "menu_click")
        
        self.dismiss(animated: true)
    }
    private let config = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // turn off catch and lure buttons while monster is not placed on the surface
        DispatchQueue.main.async {
            self.lockUI()
        }
        
        // init timer for blinking label of searching the surface
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(blinkLabel), userInfo: nil, repeats: true)
        
        // set delegates
        sceneView.delegate = self
        
        // set current moster name
        if let currAnnotation = currMonsterAnnotation {
            currMonsterName = currAnnotation.title as? String
        }
        
        // update chance of catch label
        updateChanceToCatchLabel()

        // transparent navigation bar
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        // generate random monster level between 5 and 20
        generateRandomMonsterLevel()
        
        // detect floor and other plane surfaces
        config.planeDetection = .horizontal
        
        // settings for debugging
//        sceneView.debugOptions = [
//            ARSCNDebugOptions.showFeaturePoints,
//            ARSCNDebugOptions.showWorldOrigin
//        ]
        
        // run the scene view with above configuration
        sceneView.session.run(config)
        
        // get Scene from `models.scnassets` folder with name of current monster
        let monsterScene = SCNScene(named: "models.scnassets/\(currMonsterName!.lowercased()).scn")
        
        // get child node of the scene, with name of current monster
        monsterNode = monsterScene?.rootNode.childNode(withName: "\(currMonsterName!.lowercased())", recursively: true)

    }
    
    private func lockUI() {
        tryCatchBtn.isEnabled = false
        lureButton.isEnabled = false
    }
    
    private func unlockUI() {
        tryCatchBtn.isEnabled = true
        lureButton.isEnabled = true
    }
    
    // function for blinkins search label during searching plane surface for placing monster
    @objc private func blinkLabel() {
        DispatchQueue.main.async {
            if self.searchForSurface.isHidden {
                self.searchForSurface.isHidden = false
            } else {
                self.searchForSurface.isHidden = true
            }
        }
    }
    
    @objc private func hideNoLureText() {
        searchForSurface.isHidden = true
    }
    
    private func playSound(name: String) {
        guard let url = Bundle.main.url(forResource: "\(name)", withExtension: "wav") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
        
            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
            return
        }
    
    }
    
    private func updateChanceToCatchLabel() {
        chanceOfCatchLabel.text = "Шанс: \(currChanceToCatch)"
    }

    // this function places monster name with monster level on Scene
    private func placeMonsterNameAndLevel(x: Float, y: Float, z: Float) {
        
        // create the text and give it some color
        let monsterName3d = SCNText(string: "\(currMonsterName ?? "")", extrusionDepth: 2)
        guard let monsterLevelText = currMonsterLevel else { return }
        let monsterLevel3d = SCNText(string: "Уровень: \(monsterLevelText)", extrusionDepth: 2)
        let material = SCNMaterial()
        
        material.diffuse.contents = UIColor.white
        monsterName3d.materials = [material]
        monsterLevel3d.materials = [material]
        
        // we create a new node for name
        nameNode = SCNNode()
        nameNode!.position = SCNVector3(x: x, y: y, z: z)
        nameNode!.scale = SCNVector3(x: 0.004, y: 0.004, z: 0.004)
        nameNode!.geometry = monsterName3d
        
        // new node for level
        levelNode = SCNNode()
        levelNode!.position = SCNVector3(x: x + 0.006, y: y - 0.02, z: z)
        levelNode!.scale = SCNVector3(x: 0.002, y: 0.002, z: 0.002)
        levelNode!.geometry = monsterLevel3d
        
        // we add the node to our scene and add shadows to our node
        sceneView.scene.rootNode.addChildNode(nameNode!)
        sceneView.scene.rootNode.addChildNode(levelNode!)
        sceneView.autoenablesDefaultLighting = true
    }
    
    // generating random monster level
    private func generateRandomMonsterLevel() {
        currMonsterLevel = Int.random(in: 5 ... 20)
    }
    
    // user can catch monster with a chance of 20%
    private func tryCatchMonster() {
        
        guard let safeModel = viewModel else { return }
        
        // if user uses lure, we add LURE_PERCENT_NUM(35%) to chance, so chance becomes 55%
        if safeModel.useLure {
            currChanceToCatch += Constants.LURE_PERCENT_NUM
            updateChanceToCatchLabel()
        }
        
        // if random possibility less than chance, we catched monster!
        if Int.random(in: 0...100) <= currChanceToCatch {
            self.playSound(name: "success_catch")
            
            // if catched -> add to catchedMonsters array and cache
            let catchedMonster = Monster(name: currMonsterName ?? "", level: currMonsterLevel)
            safeModel.catchedMonsters.append(catchedMonster)
            
            // save in user defaults after moster catched
            viewModel?.cacheGameState()
            
            // remove monster from Scene
            removeMonsterFromScene()
            
            let alert = UIAlertController(title: "Ура!", message: "Вы поймали монстра \(currMonsterName ?? "") в свою команду", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Вернуться на карту", style: .default, handler: { action in
                self.removeCurrentMonsterFromMap()
                self.goToMap()
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            // if not catched, then monster can run away with 50% possibility
            if (Int.random(in: 0...100) <= Constants.RUN_AWAY_CHANCE) {
                playSound(name: "monster_run")
                // remove monster from Scene
                removeMonsterFromScene()
                
                let alert = UIAlertController(title: "Ээх!", message: "Монстр убежал!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Вернуться на карту", style: .default, handler: { action in
                    self.removeCurrentMonsterFromMap()
                    self.goToMap()
                }))
                
                self.present(alert, animated: true, completion: nil)
                
            } else {
                playSound(name: "fail_catch")
                // if monster is not ran away, we can try catch one more time
                let alert = UIAlertController(title: "Не вышло :(", message: "Попробуйте поймать еще раз!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        // set use lure and chance to catch back to normal
        safeModel.useLure = false
        currChanceToCatch = Constants.CHANCE_OF_CATCH
    }
    
    private func removeMonsterFromScene() {
        monsterNode?.removeFromParentNode()
        nameNode?.removeFromParentNode()
        levelNode?.removeFromParentNode()
    }
    
    // removes current catched monster from map
    private func removeCurrentMonsterFromMap() {
        // remove monster from map
        if let indexOfMonster = viewModel?.allMonsters.firstIndex(where: {
            $0 === currMonsterAnnotation
        }) {
            viewModel?.allMonsters.remove(at: indexOfMonster)
            viewModel?.mapView?.removeAnnotation(currMonsterAnnotation!)
        }
    }
    
    // dispmiss the controller and show map
    private func goToMap() {
        self.dismiss(animated: true)
    }
    
}

extension CatchMonsterVC: ARSCNViewDelegate {
    
    // place monster on detected surface
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        // hide search for surface label
        DispatchQueue.main.async {
            // invalidate timer
            self.timer?.invalidate()
            self.timer = nil
            self.searchForSurface.isHidden = true
        }
        
        guard !surfaceDetected else { return }
        surfaceDetected = true

        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }

        let x = CGFloat(planeAnchor.transform.columns.3.x)
        let y = CGFloat(planeAnchor.transform.columns.3.y)
        let z = CGFloat(planeAnchor.transform.columns.3.z)
        let position = SCNVector3(x,y,z)
        
        
        // place monster on detected surface
        if let monsterNode = monsterNode {
            monsterNode.scale = SCNVector3(0.05, 0.05, 0.05)
            sceneView.scene.rootNode.addChildNode(monsterNode)
            monsterNode.position = position
            
            // add text for monster name and level
            placeMonsterNameAndLevel(x: Float(x) - 0.1, y: Float(y) + 0.28, z: Float(z))
            
            // turn on catch and lure buttons when monster appears on the surface
            DispatchQueue.main.async {
                self.unlockUI()
            }
        }

    }
    
}
