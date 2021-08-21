//
//  AccelerometerResultViewController.swift
//  IHC_TP2
//
//  Created by Henrique Conte on 21/08/21.
//

import UIKit

class AccelerometerResultViewController: UIViewController {
    
    @IBAction func nextButtonTouched(_ sender: Any) {
        performSegue(withIdentifier: "showLuminosityVC", sender: nil)
    }
}

