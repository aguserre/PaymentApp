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
    
    func getPaymentMethod(parameters: [String: Any] ,completion: @escaping ([PaymentMethod]) -> Void) {
        Alamofire.request(PAYMENT_METHODS, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let json = response.result.value as? [[String: Any]] {
                var arrayPaymentsMethod = [PaymentMethod]()
                for jsonPayMethod in json{
                    if let payObject = PaymentMethod(JSON: jsonPayMethod) {
                        arrayPaymentsMethod.append(payObject)
                    }
                }
                completion(arrayPaymentsMethod)
            } else {
                print("errorrrrrrrrr")
            }
        }
    }


}
