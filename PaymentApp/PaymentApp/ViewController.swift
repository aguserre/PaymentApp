//
//  ViewController.swift
//  PaymentApp
//
//  Created by Agustin Errecalde on 11/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit
import FirebaseAnalytics

class ViewController: UIViewController {

    @IBOutlet weak var currenciCodeTextField: UITextField!
    @IBOutlet weak var nextStepButton: UIButton!
    @IBOutlet weak var tabBarView: UIView!
    
    var paymentMethod: [PaymentMethodModel]?
    
    var amount = 0
    lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currenciCodeTextField.delegate = self
        currenciCodeTextField.placeholder = updateTextField()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .white
        
        
        let parameters = ["public_key":PUBLIC_KEY_API]
        let service = PaymentMethodService()
        service.getPaymentMethod(parameters: parameters) { (array) in
            self.paymentMethod = array
        }
        configureNavigationBar()
        configureTabBar()
        configureButonNext()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        amount = 0
        currenciCodeTextField.text = ""
        if currenciCodeTextField.text == ""{
            amount = amount/10
        }
    }
    
    func configureNavigationBar(){
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.cornerRadius = 10
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.8
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationItem.title = "Payment App"
        self.navigationItem.prompt = "Welcome"
    }
    
    func configureTabBar(){
        self.tabBarView.layer.cornerRadius = 30
        self.tabBarView.layer.shadowRadius = 4.0
        self.tabBarView?.layer.shadowOpacity = 0.8
        self.tabBarView?.layer.masksToBounds = false
    }
    
    func configureButonNext(){
        self.nextStepButton.layer.cornerRadius = 40
        self.nextStepButton.layer.shadowRadius = 10
        self.nextStepButton?.layer.shadowOpacity = 0.8
        self.nextStepButton?.layer.masksToBounds = false
    }
    
    func updateTextField() -> String? {
        let number = Double(amount/100) + Double(amount%100)/100
        return numberFormatter.string(from: NSNumber(value: number))
    }
    
    @IBAction func goToPaymentMethod(_ sender: Any) {
        Analytics.logEvent("goToPayMethodTapped", parameters: nil)
        if amount/100 >= 10 {
            let paymentMethodViewController = PaymentMethodsTableViewController()
            let doubleAmount = Double(amount/100) + Double(amount%100)/100
            paymentMethodViewController.amountString = numberFormatter.string(from: NSNumber(value: doubleAmount))
            paymentMethodViewController.amount = amount
            
            if let paymentMethods = paymentMethod {
                paymentMethodViewController.paymentMethod = paymentMethods
            }
            currenciCodeTextField.text = updateTextField()
            navigationController?.pushViewController(paymentMethodViewController, animated: true)
        } else {
            showAlertAmount()
        }
    }
    
    func showAlertAmount(){
        Analytics.logEvent("errorMinAmount", parameters: nil)
        let alert = UIAlertController(title: "Error", message: "The minimum amount must be 10", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
