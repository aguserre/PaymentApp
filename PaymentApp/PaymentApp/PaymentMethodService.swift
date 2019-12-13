//
//  PaymentMethodService.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 12/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit

class PaymentMethodService {

    func getPaymentMethod(parameters:[String:Any], completion: @escaping ([PaymentMethodModel]) -> Void) {
        let dao = PaymentMethodDAO()
        dao.getPaymentMethod(parameters: parameters) { (method) in
            completion(method)
        }
    }

}
