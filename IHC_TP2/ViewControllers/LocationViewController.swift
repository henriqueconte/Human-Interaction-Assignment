//
//  LocationViewController.swift
//  IHC_TP2
//
//  Created by Henrique Conte on 05/08/21.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    let locationManager: CLLocationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        updateLocation()
    }
    
    private func updateLocation() {
        timer = Timer(fire: Date(), interval: 1/60, repeats: true) { timer in
            if self.locationManager.authorizationStatus == .authorizedWhenInUse,
               let newLocation: CLLocation = self.locationManager.location {
                self.latitudeTextField.text = "\(newLocation.coordinate.latitude)"
                self.longitudeTextField.text = "\(newLocation.coordinate.longitude)"
            }
        }
        
        RunLoop.current.add(timer!, forMode: .default)
    }
    
    @IBAction func nextButtonTouched(_ sender: Any) {
        timer?.invalidate()
        navigationController?.popToRootViewController(animated: true)
    }
}
