//
//  LocationForbiddenVC.swift
//  Monster Track
//
//  Created by Николай Ногин on 13.12.2022.
//

import UIKit
import CoreLocation

class LocationForbiddenVC: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var subMessage: UILabel!
    @IBOutlet weak var goToSettingsBtn: UIButton!
    
    private var locationManager: CLLocationManager?
    
    @IBAction func openSettingsBtnClicked(_ sender: Any) {
        // redirect to Settings
        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // hide goToSettings button at start
        hideGoToSettingsBtn()
        
        // initialize location manager, set this VC as delegate
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }
    
    private func hideGoToSettingsBtn() {
        // this disables and hides goToSettings button
        goToSettingsBtn.isEnabled = false
        goToSettingsBtn.isHidden = true
    }
    
    private func showGoToSettingsBtn() {
        // this disables and hides goToSettings button
        goToSettingsBtn.isEnabled = true
        goToSettingsBtn.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "Необходимы данные о вашей геолокации", message: "Для продолжения, пожалуйста, разрешите использование сервисов геолокации в настройках вашего IPhone", preferredStyle: UIAlertController.Style.alert)

        let goToSettingsAction = UIAlertAction(title: "Перейти в Настройки", style: .default, handler: {(cAlertAction) in
            
            self.showInstructions()
            // redirect to settings
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        })

        let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertAction.Style.cancel) { _ in
            self.showInstructions()
        }

        alert.addAction(goToSettingsAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
    
    func showInstructions() {
        // change label and show goToSettings button
        self.messageLabel.text = "Включить её можно в настройках IPhone, в меню «Конфиденциальность» -> «Службы геолокации»."
        self.subMessage.text = "К сожалению, без неё мы не сможем продолжить :("
        self.showGoToSettingsBtn()
    }
    
}

extension LocationForbiddenVC: CLLocationManagerDelegate {
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locationManager!.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            // location services are available
            performSegue(withIdentifier: "fromLocationForbiddenToMap", sender: nil)
            break
            
        case .restricted, .denied:
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
                        break
                        
                    default:
                        break
                    }
                }
            }
        }
    }
    
//    private func hasLocationPermission() -> Bool {
//        var hasPermission = false
//        if CLLocationManager.locationServicesEnabled() {
//            switch CLLocationManager.authorizationStatus() {
//            case .notDetermined, .restricted, .denied:
//                hasPermission = false
//            case .authorizedAlways, .authorizedWhenInUse:
//                hasPermission = true
//            default:
//                return false
//            }
//        } else {
//            hasPermission = false
//        }
//
//        return hasPermission
//    }
}
