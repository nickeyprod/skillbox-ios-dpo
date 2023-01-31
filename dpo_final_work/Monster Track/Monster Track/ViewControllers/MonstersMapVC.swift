//
//  MonstersMapVC.swift
//  Monster Track
//
//  Created by Николай Ногин on 13.12.2022.
//

import SwiftUI
import MapKit

class MonstersMapVC: UIViewController, CLLocationManagerDelegate {
    
    // actions and outlets coming there next
    @IBOutlet weak var zoomPlusBtn: UIButton!
    @IBOutlet weak var zoomMinusBtn: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func zoomPlusBtnPressed(_ sender: Any) {
        zoomInMap()
    }
    
    @IBAction func zoomMinusBtnPressed(_ sender: Any) {
        zoomOutMap()
    }
    
    @IBAction func myTeamBtnPressed(_ sender: Any) {
        // go to My Team View
        performSegue(withIdentifier: "fromMapToMyTeam", sender: nil)
    }
    
    @IBAction func showUserLocationBtnPressed(_ sender: Any) {
        showUserLocationRegion()
    }
    
    // properties coming there next
    var viewModel = ViewModel()
    
    private let locationManager = CLLocationManager()
    
    private var currentUserLocation: CLLocationCoordinate2D? = nil
    private var currentUserVisibleCircle: MKCircle? = nil
    private var currentUserInvisibleCircle: MKCircle? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set globally updated variables on view model
        viewModel.mapView = mapView
        
        viewModel.updateTimer = Timer.scheduledTimer(timeInterval: Constants.MONSTER_UPDATE_TIME, target: self, selector: #selector(updateMonsters), userInfo: nil, repeats: true)
        
        // round corners of buttons
        zoomPlusBtn.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        zoomMinusBtn.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        // setting all delegates
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        // register all annotations (monsters) for faster reuse on map
        registerMapAnnotationViews()
        
    }
    
    // when going from map to next VC, we set needed there variables
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // when go from map to `CatchMonsterVC`
        if (segue.identifier == "fromMapToCatchMonster") {
            guard let tappedMonsterAnnotation = sender as? MonsterAnnotation else { return }
            guard let catchMonsterVC = segue.destination as? CatchMonsterVC else { return }
            catchMonsterVC.currMonsterAnnotation = tappedMonsterAnnotation
            catchMonsterVC.viewModel = viewModel
        }
        // when go from map to `MyTeamVC`
        else if (segue.identifier == "fromMapToMyTeam") {
            guard let myTeamVC = segue.destination as? MyTeamVC else { return }
            myTeamVC.viewModel = viewModel
        }
    }
    
    // function returns lure annotation with 20% chance
    private func getLureAtRandomPositionAroundUser() -> MKAnnotation? {
 
        if Int.random(in: 0...100) <= Constants.CHANCE_TO_PLACE_LURE {
            while true {
                // here we get random point on map
                if let randomPoint = getRandomPointWithinInvisibleCircle() {
                    // create new Lure annotation to display on map
                    let newLureAnnotation = LureAnnotation(latitude: randomPoint.coordinate.latitude, longitude: randomPoint.coordinate.longitude)
                    let distance = getDistanceBetweenUserAndAnnotation(annotation: newLureAnnotation)
                    if distance < Constants.MONSTERS_AREA_IN_METERS {
                        return newLureAnnotation
                    }
                }
            }
        }
        return nil
    }
    
    // func adds additional required num of monsters to `currentUserInvisibleCircle`
    // and display if have any visible
    // also adds some lure at user radius with 20% chance
    private func addRandomMonstersInInvisibleCircleOf(num mostersCount: Int) {
        // try to add lure
        if let lureAnnotation = getLureAtRandomPositionAroundUser() {
            viewModel.allMonsters.append(lureAnnotation)
        }
        
        var i = 0
        while (i <= mostersCount) {
            if let newMonsterAnnotation = getRandomMoster() {
                // make sure distance between user and monster less than `MONSTERS_AREA_IN_METERS km`
                // otherwise generate new monster
                let distanceBetweenUserAndAnnotation = getDistanceBetweenUserAndAnnotation(annotation:  newMonsterAnnotation)
                if distanceBetweenUserAndAnnotation < Constants.MONSTERS_AREA_IN_METERS {
                    viewModel.allMonsters.append(newMonsterAnnotation)
                    i += 1
                }
            }
        }
    }
    
    // runs every 5 minutes to update list of mosters in `currentUserInvisibleCircle` area
    @objc private func updateMonsters() {
        
        var lastElementParsed = false
        var lastRemovedIndex = 0
        var maxRepeat = viewModel.allMonsters.count - 1
        
        // remove every moster with a 20% chance
        while (!lastElementParsed && maxRepeat != 0) {
            maxRepeat -= 1
            for index in lastRemovedIndex ..< viewModel.allMonsters.count {
                let isRemove = randomBoolPercentage(percentage: 20)
                
                if (isRemove) {
                    viewModel.allMonsters.remove(at: index)
                    lastRemovedIndex = index
                    if lastRemovedIndex == viewModel.allMonsters.count - 1 {
                        lastElementParsed = true
                    }
                    
                    // start for loop again as allMonsters.count has changed
                    break
                }
            }
        }
        // adding 6 new random monsters at random locations instead of removed monsters
        addRandomMonstersInInvisibleCircleOf(num: 6)
    }
    
    // returns true with required percentage
    private func randomBoolPercentage(percentage: Int) -> Bool {
        return Int.random(in: 0...100) < percentage
    }
    
    // removes from map monsters that more than `RADIUS_IN_METERS` away from user (300m)
    private func removeInvisibleMonsters() {
        
        for monster in mapView.annotations {
            // get distance between monster and user
            let distanceBetweenUserAndAnnotation = getDistanceBetweenUserAndAnnotation(annotation: monster)
            
            // if monster not within visible area, hide it
            if (distanceBetweenUserAndAnnotation > Constants.RADIUS_IN_METERS) {
                // remove it from map
                mapView.removeAnnotation(monster)
                
            }
        }
    }
    
    // displays monsters that appers in `currentUserVisibleCircle` (300m)
    private func displayVisibleMonsters() {
        
        for monster in viewModel.allMonsters {
            
            // make sure distance between user and monster less than `RADIUS_IN_METERS m`
            let distanceBetweenUserAndMonster = getDistanceBetweenUserAndAnnotation(annotation: monster!)
            
            if distanceBetweenUserAndMonster < Constants.RADIUS_IN_METERS {
                var isMonsterOnMap = false
                // check if annotation already added
                for a in mapView.annotations {
                    if a.coordinate.longitude == monster?.coordinate.longitude && a.coordinate.latitude == monster?.coordinate.latitude {
                        isMonsterOnMap = true
                    }
                }
                // if there is no such monster on map then add it
                if !isMonsterOnMap {
                    mapView.addAnnotation(monster!)
                }
            }
            
        }
    }
    
    // convert given annotation and user coordinates to points and measure distance between them
    private func getDistanceBetweenUserAndAnnotation(annotation: MKAnnotation) -> CLLocationDistance {
        
        let annotationPoint = MKMapPoint(annotation.coordinate)
        let userCoordinate = CLLocationCoordinate2D(latitude: currentUserLocation?.latitude ?? 0, longitude: currentUserLocation?.longitude ?? 0)
        let userPoint = MKMapPoint(userCoordinate)
        
        return annotationPoint.distance(to: userPoint)
    }
    
    // generates `MONSTERS_NUM` of random monsters within `currentUserInvisibleCircle`
    private func generateRandomMonstersAroundUser() {
        
        var genMonsters: [MKAnnotation] = []
        
        while genMonsters.count < Constants.MONSTERS_NUM {
            
            if let newMonsterAnnotation = getRandomMoster() {
                // make sure distance between user and monster less than `MONSTERS_AREA_IN_METERS km`
                // otherwise generate new monster
                let distanceBetweenUserAndMonster = getDistanceBetweenUserAndAnnotation(annotation: newMonsterAnnotation)
                
                if distanceBetweenUserAndMonster < Constants.MONSTERS_AREA_IN_METERS {
                    genMonsters.append(newMonsterAnnotation)
                }
            }
        }
        // assign `genMonsters` to allMonsters
        viewModel.allMonsters = genMonsters
        // add some lure if have chance
        if let lureAnnotation = getLureAtRandomPositionAroundUser() {
            viewModel.allMonsters.append(lureAnnotation)
        }
    }
    
    // creating and returns one random monster annotation
    func getRandomMoster() -> MKAnnotation? {
        // here we get random point on map and creating every new monster on this coordinates
        let randomPoint = getRandomPointWithinInvisibleCircle()
        // here we choose random type of monster from constants list
        let randNum = Int.random(in: 0 ..< Constants.POSSIBLE_MONSTERS.count)
        
        if let randomPoint = randomPoint {
            // initialize monster and add it to `genMonsters`
            let randMonster = Monster(name: Constants.POSSIBLE_MONSTERS[randNum], level: nil)
            let newMonsterAnnotation = MonsterAnnotation(monster: randMonster, latitude: randomPoint.coordinate.latitude, longitude: randomPoint.coordinate.longitude)
            return newMonsterAnnotation
        }
        return nil
    }
    
    // register the annotation views with the `mapView` so the system can create and efficently reuse the annotation views.
    private func registerMapAnnotationViews() {
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(MonsterAnnotation.self))
        mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(LureAnnotation.self))
    }
    
    // zoom In map
    private func zoomInMap() {
        
        let currLat = mapView.region.span.latitudeDelta
        let currLon = mapView.region.span.longitudeDelta
        
        let newLat = currLat - (currLat * 0.25)
        let newLon = currLon  - (currLon * 0.25)
        
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: newLat, longitudeDelta: newLon)
        let region = MKCoordinateRegion(center: mapView.region.center, span: coordinateSpan)
        mapView.setRegion(region, animated: true)
        
    }
    
    // zoom Out map
    private func zoomOutMap() {
        
        let currLat = mapView.region.span.latitudeDelta
        let currLon = mapView.region.span.longitudeDelta
        
        let newLat = currLat * 1.332
        let newLon = currLon * 1.332
        
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: newLat, longitudeDelta: newLon)
        let region = MKCoordinateRegion(center: mapView.region.center, span: coordinateSpan)
        mapView.setRegion(region, animated: true)
    }
    
    // show user location dot in the center of screen
    private func showUserLocationRegion() {
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
        if let safeUserLocation = self.currentUserLocation {
            let region = MKCoordinateRegion(center: safeUserLocation, span: coordinateSpan)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // this function updates every when user location changed
    @objc func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // update curret user location variable
        self.currentUserLocation = manager.location?.coordinate
        
        // remove old overlay before adding another one
        // uncommet this line when you need to add blue circles overlays around user location
//        mapView.removeOverlays(mapView.overlays)
        
        // add invisible circle of required radius where monsters are invisible
        addInvisibleCircleOnMapAroundUserPosition(of: Constants.MONSTERS_AREA_IN_METERS)
        
        // add visible circle of required radius where monsters start to be visible
        addVisibleCircleOnMapAroundUserPosition(of: Constants.RADIUS_IN_METERS)
        
        if viewModel.firstRun && currentUserVisibleCircle != nil && currentUserInvisibleCircle != nil  {
            // generate monsters first time
            generateRandomMonstersAroundUser()
            viewModel.firstRun = false
        }
        
        // update visible monsters when user moving
        removeInvisibleMonsters()
        displayVisibleMonsters()
    }
    
    // adding circle of 'visibillity' around user coordinates, it displays monsters from inivisible area,
    // when monster are appearing in this circle
    private func addVisibleCircleOnMapAroundUserPosition(of radius: CLLocationDistance)  {
        
        guard let userLocation = self.currentUserLocation else { return }
        
        // create circle of needed radius
        currentUserVisibleCircle = MKCircle(center: userLocation, radius: radius)
        if let userCircle = currentUserVisibleCircle {
            mapView.addOverlay(userCircle)
        }
    }
    
    // adding invisible circle around user position of radius (1km)
    // `invisible` because monsters in this radius are not displayed on map until user comes in
    private func addInvisibleCircleOnMapAroundUserPosition(of radius: CLLocationDistance)  {
        
        guard let userLocation = self.currentUserLocation else { return }
        
        // create circle of needed radius
        currentUserInvisibleCircle = MKCircle(center: userLocation, radius: radius)
        if let userCircle = currentUserInvisibleCircle {
            mapView.addOverlay(userCircle)
        }
    }
    
    // creates random x and y coordinates within `currentUserInvisibleCircle` radius (1km)
    // for placing random monster at these coordinates
    private func getRandomXYWithinInvisibleCircle() -> (Double, Double)? {
        // get rectangular area the same size as the above circle
        if let rect = currentUserInvisibleCircle?.boundingMapRect {
            let randX = Double.random(in: rect.origin.x...rect.origin.x + rect.width)
            let randY = Double.random(in: rect.origin.y...rect.origin.y + rect.height)
            return (randX, randY)
        }
        return nil
    }
    
    // generates random `MKMapPoint` for converting x and y cordinates to lattitude and longitude
    private func getRandomPointWithinInvisibleCircle() -> MKMapPoint? {
        if let randomXY = getRandomXYWithinInvisibleCircle() {
            // create `mapPoint` for getting coordinates where to place monster
            let mapPoint = MKMapPoint(x: randomXY.0, y: randomXY.1)
            return mapPoint
        }
        return nil
    }
    
    // simple logic to get right endings for the word `метров` with varied last digit
    private func getMetersRightEnding(num: Int) -> String {
        let numberString = String(num)
        var message = "метров"
        let lastDigit = Int(String(numberString.last!)) ?? 0
        if num > 10 && num < 21  {
            return message
        }
        else if lastDigit == 1 {
            message = "метр"
        } else if lastDigit > 2 && lastDigit < 5 {
            message = "метра"
        }
        return message
    }
    
    private func deselectAllAnnotations() {
        for annotation in mapView.annotations {
            mapView.deselectAnnotation(annotation, animated: false)
        }
    }
    
}

extension MonstersMapVC: MKMapViewDelegate {
    
    // function runs when annotation tapped (selecred) by user
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        // deselect all annotations, so user could tap on the same annotation if needed
        deselectAllAnnotations()
        
        guard !(view.annotation?.isKind(of: MKUserLocation.self) ?? false) else {
            // make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to open
            return
        }
        
        // get distance betwee monster and tapped annotation (monster)
        let distance = getDistanceBetweenUserAndAnnotation(annotation: view.annotation!)
        
        // open catchMonsterVC only if distance between monster and user less than 100 m
        if distance <= Constants.OPEN_CATCH_METERS {
            if view.annotation is MonsterAnnotation {
                DispatchQueue.main.async {
                    // go to My Team View
                    self.performSegue(withIdentifier: "fromMapToCatchMonster", sender: view.annotation)
                }
            } else {
                
                viewModel.lureCount += 1
                
                // cache lure count
                viewModel.cacheGameState()
                
                if let indexOfLure = viewModel.allMonsters.firstIndex(where: { $0 === view.annotation }) {
                    viewModel.allMonsters.remove(at: indexOfLure)
                    if let annotation = view.annotation {
                        mapView.removeAnnotation(annotation)
                    }
                }
            }

        } else {
            let alert = UIAlertController(title: "Не выйдет!", message: "Вы находитесь слишком далеко от этого монстра - \(Int(distance)) \(getMetersRightEnding(num: Int(distance))). Подойдите ближе!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // the map view asks `mapView(_:viewFor:)` for an appropiate annotation view for a specific annotation
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize
            return nil
        }
        
        var annotationView: MKAnnotationView?
        
        if let annotation = annotation as? MonsterAnnotation {
            annotationView = setupMonsterView(for: annotation, on: mapView)
        }
        else if let annotation = annotation as? LureAnnotation {
            annotationView = setupLureView(for: annotation, on: mapView)
        }
        
        return annotationView
    }
    
    /// the map view asks `mapView(_:viewFor:)` for an appropiate annotation view for a specific annotation
    /// the annotation should be configured as needed before returning it to the system for display
    private func setupMonsterView(for annotation: MonsterAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        
        let reuseIdentifier = NSStringFromClass(MonsterAnnotation.self)
        let monsterView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation)
        
        // provide the annotation view's image
        monsterView.image = UIImage(named: annotation.monster.pic)
        
        return monsterView
    }
    
    private func setupLureView(for annotation: LureAnnotation, on mapView: MKMapView) -> MKAnnotationView {
        
        let reuseIdentifier = NSStringFromClass(LureAnnotation.self)
        let lureView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier, for: annotation)
        
        // provide the annotation view's image
        lureView.image = UIImage(named: "lure")

        return lureView
    }
    
    // uncomment this function for displaying blue circle overlay around user on map
    // and then also unccoment one line in `locationManager` function to actually add overlays!
    
    //    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    //
    //        guard let circelOverLay = overlay as? MKCircle else {return MKOverlayRenderer()}
    //
    //        let circleRenderer = MKCircleRenderer(circle: circelOverLay)
    //        circleRenderer.strokeColor = .blue
    //        circleRenderer.fillColor = .blue
    //        circleRenderer.alpha = 0.2
    //        return circleRenderer
    //    }
    
}
