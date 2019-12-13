//
//  CardIssuersService.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 13/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit

class CardIssuersService {
    
    func getCardIssuers(parameters:[String:Any], completion: @escaping ([CardIssuersModel]) -> Void) {
        let dao = CardIssuersDAO()
        dao.getCardIssuers(parameters: parameters) { (issuers) in
            completion(issuers)
        }
    }
}
