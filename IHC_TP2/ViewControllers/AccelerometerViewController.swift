//
//  AccelerometerViewController.swift
//  IHC_TP2
//
//  Created by Henrique Conte on 05/08/21.
//

import UIKit
import CoreMotion

class AccelerometerViewController: UIViewController {
    @IBOutlet weak var axisXTextField: UITextField!
    @IBOutlet weak var axisYTextField: UITextField!
    @IBOutlet weak var axisZTextField: UITextField!
    let motion: CMMotionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        startAccelerometers()
    }
    
    private func startAccelerometers() {
        if motion.isAccelerometerAvailable {
            motion.accelerometerUpdateInterval = 1 / 60
            motion.startAccelerometerUpdates()
            
            let timer: Timer = Timer(fire: Date(), interval: 1/60, repeats: true) { timer in
                if let data: CMAccelerometerData = self.motion.accelerometerData {
                    self.axisXTextField.text = "\(data.acceleration.x)"
                    self.axisYTextField.text = "\(data.acceleration.y)"
                    self.axisZTextField.text = "\(data.acceleration.z)"
                    
                    if data.acceleration.x > 0.7 {
                        timer.invalidate()
                        self.performSegue(withIdentifier: "showAccelerometerResultVC", sender: nil)
                    }
                }
            }
            RunLoop.current.add(timer, forMode: .default)
        }
    }
    
    @IBAction func nextButtonTouched(_ sender: Any) {
        performSegue(withIdentifier: "showGyroscopeVC", sender: nil)
    }
    
}
