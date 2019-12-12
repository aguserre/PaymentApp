//
//  PaymentMethodDAO.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 12/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit
import Alamofire

class PaymentMethodDAO {
    
    func getPreference(completion: @escaping (PaymentMethod) -> Void) {
        Alamofire.request(PAYMENT_METHODS).responseJSON { (response) in
            if let json = response.result.value as? [String: AnyObject] {
                if let paymentMethod = json["preferenceID"] as? String {
                    completion(paymentMethod)
                }
            }
        }
    }


}
