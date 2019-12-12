//
//  ProductsDao.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 12/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit
import Alamofire

class ProductDAO {
    
    func getPreference(completion: @escaping (String) -> Void) {
        Alamofire.request("https://mercadotest.herokuapp.com/api/createTransaction").responseJSON { (response) in
            if let key = response.result.value as? [String: AnyObject] {
                if let preferenceId = key["preferenceID"] as? String {
                    completion(preferenceId)
                }
            }
        }
    }


}
