//
//  ViewController.swift
//  Monster Track
//
//  Created by Николай Ногин on 12.12.2022.
//

import UIKit
import CoreLocation

class RequestLocationVC: UIViewController {
    
    private var locationManager: CLLocationManager?

    @IBAction func allowLocationBtnPressed(_ sender: Any) {
        // request geolocation permissions when button tapped
        requestGeo()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize location manager, set this VC as delegate and request access
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    // this function requests user permissions for tracking geolocation
    private func requestGeo() {
        locationManager?.requestAlwaysAuthorization()
    }

}

extension RequestLocationVC: CLLocationManagerDelegate {
    
    // for ios 14 and above
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager!.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            // location services are available
            performSegue(withIdentifier: "fromReqToMosntersMap", sender: nil)
            break
            
        case .restricted, .denied:
            // location services currently unavailable
            performSegue(withIdentifier: "fromReqGeoToGeoForbidden", sender: nil)
            break
            
        default:
            break
        }
    }

    // for ios 13 and lower
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    switch CLLocationManager.authorizationStatus() {
                    case .authorizedWhenInUse, .authorizedAlways:
                        // location services are available
                        performSegue(withIdentifier: "fromReqToMosntersMap", sender: nil)
                        break
                        
                    case .restricted, .denied:
                        // location services currently unavailable
                        performSegue(withIdentifier: "fromReqGeoToGeoForbidden", sender: nil)
                        break
                        
                    default:
                        break
                    }
                }
            }
        }
    }

}
