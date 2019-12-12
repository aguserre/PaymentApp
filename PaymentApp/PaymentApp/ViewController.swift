//
//  ViewController.swift
//  PaymentApp
//
//  Created by Agustin Errecalde on 11/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currenciCodeTextField: UITextField!
    @IBOutlet weak var nextStepButton: UIButton!
    
    var preferenceID = ""
    var amount = 0
    lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currenciCodeTextField.delegate = self
    }
    
    func updateTextField() -> String? {
        let number = Double(amount/100) + Double(amount%100)/100
        return numberFormatter.string(from: NSNumber(value: number))
    }
    
    @IBAction func goToPaymentMethod(_ sender: Any) {
        let paymentMethodViewController = PaymentMethodsTableViewController()
        paymentMethodViewController.amount = amount
        
        navigationController?.pushViewController(paymentMethodViewController, animated: true)
    }
    
    
    
}




extension ViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let character = Int(string){
            amount = amount * 10 + character
            currenciCodeTextField.text = updateTextField()
        }
        if string == ""{
            amount = amount/10
            currenciCodeTextField.text = updateTextField()
        }
        return false
    }
    
}
