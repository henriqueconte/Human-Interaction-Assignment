//
//  SumViewController.swift
//  IHC_TP2
//
//  Created by Henrique Conte on 21/08/21.
//

import UIKit

class SumViewController: UIViewController {
    
    @IBOutlet weak var firstNumberTextField: UITextField!
    @IBOutlet weak var secondNumberTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNumberTextField.delegate = self
        secondNumberTextField.delegate = self
    }
    
    @IBAction func sumButtonTouched(_ sender: Any) {
        let sum: Double = (Double(firstNumberTextField.text ?? "") ?? 0) + (Double(secondNumberTextField.text ?? "") ?? 0)
        
        resultLabel.text = "RESULT: \(sum)"
    }
    
    @IBAction func showNextActivity(_ sender: Any) {
        performSegue(withIdentifier: "showActivity2", sender: nil)
    }
}

extension SumViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
