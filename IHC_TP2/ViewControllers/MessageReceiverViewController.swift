//
//  MessageReceiverViewController.swift
//  IHC_TP2
//
//  Created by Henrique Conte on 05/08/21.
//

import UIKit

class MessageReceiverViewController: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    var message: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = message
    }
    
    @IBAction func nextButtonTouched(_ sender: Any) {
        performSegue(withIdentifier: "showAccelerometerVC", sender: nil)
    }
}
