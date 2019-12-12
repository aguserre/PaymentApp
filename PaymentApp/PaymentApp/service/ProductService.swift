//
//  ProductsService.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 12/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit

class ProductService {

    func getPreference(completion: @escaping (String) -> Void) {
        let dao = ProductDAO()
        dao.getPreference { (preferenceID) in
            completion(preferenceID)
        }
    }

}
