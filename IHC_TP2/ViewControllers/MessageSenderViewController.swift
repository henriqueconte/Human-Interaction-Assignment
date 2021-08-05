//
//  MessageSenderViewController.swift
//  IHC_TP2
//
//  Created by Henrique Conte on 05/08/21.
//

import UIKit

class MessageSenderViewController: UIViewController {
    @IBOutlet weak var messageTextField: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let messageReceiverVC: MessageReceiverViewController =  segue.destination as? MessageReceiverViewController {
            messageReceiverVC.message = messageTextField.text
        }
    }
    
    @IBAction func sendButtonTouched(_ sender: Any) {
        performSegue(withIdentifier: "showMessageReceiverVC", sender: nil)
    }
}
