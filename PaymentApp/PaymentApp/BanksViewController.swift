//
//  BanksViewController.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 13/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit

class BanksViewController: UIViewController {
    
    var amount: Int?
    var amountString : String?
    var paymentMethod: PaymentMethodModel?
    var carIssuersArray: [CardIssuersModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameters = ["public_key":PUBLIC_KEY_API,
                        "payment_method_id": paymentMethod?.id ?? ""]
        
        let service = CardIssuersService()
        service.getCardIssuers(parameters: parameters) { (array) in
            self.carIssuersArray = array
        }
        
        
    }
    



}
