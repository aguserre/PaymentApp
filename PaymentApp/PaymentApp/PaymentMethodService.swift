//
//  PaymentMethodService.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 12/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit

class PaymentMethodService {

    func getPreference(completion: @escaping (String) -> Void) {
        let dao = PaymentMethodDAO()
        dao.getPreference { (preferenceID) in
            completion(preferenceID)
        }
    }

}
