//
//  InstallmentsViewController.swift
//  PaymentApp
//
//  Created by Agustin Errecalde on 14/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit

class InstallmentsViewController: UIViewController {
    
    var amount: Int?
    var amountString : String?
    var paymentMethod: PaymentMethodModel?
    var cardIssuers: CardIssuersModel?

    @IBOutlet weak var viewBackgroundDetail: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
