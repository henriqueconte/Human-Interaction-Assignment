//
//  GyroscopeViewController.swift
//  IHC_TP2
//
//  Created by Henrique Conte on 05/08/21.
//

import UIKit
import CoreMotion

class GyroscopeViewController: UIViewController {
    let motion: CMMotionManager = CMMotionManager()
    @IBOutlet weak var axisXTextField: UITextField!
    @IBOutlet weak var axisYTextField: UITextField!
    @IBOutlet weak var axisZTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGyroscope()
    }
    
    private func startGyroscope() {
        if motion.isGyroAvailable {
            motion.gyroUpdateInterval = 1 / 60
            motion.startGyroUpdates()
            
            let timer: Timer = Timer(fire: Date(), interval: 1/60, repeats: true) { [weak self] timer in
                guard let self = self else { return }
                if let data: CMGyroData = self.motion.gyroData {
                    self.axisXTextField.text = "\(data.rotationRate.x)"
                    self.axisYTextField.text = "\(data.rotationRate.y)"
                    self.axisZTextField.text = "\(data.rotationRate.z)"
                }
            }
            
            RunLoop.current.add(timer, forMode: .default)
        }
    }
    
    @IBAction func nextButtonTouched(_ sender: Any) {
        performSegue(withIdentifier: "showLocationVC", sender: nil)
    }
    
}
