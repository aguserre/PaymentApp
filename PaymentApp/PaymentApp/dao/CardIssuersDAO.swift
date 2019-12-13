//
//  CardIssuersDAO.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 13/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit
import Alamofire

class CardIssuersDAO {
    
    func getCardIssuers(parameters: [String: Any] ,completion: @escaping ([CardIssuersModel]) -> Void) {
        Alamofire.request(CARD_ISSUES, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let json = response.result.value as? [[String: Any]] {
                var arrayCardIssuers = [CardIssuersModel]()
                
                for jsonCardIssuers in json{
                    if let issuersObject = CardIssuersModel(JSON: jsonCardIssuers) {
                        arrayCardIssuers.append(issuersObject)
                    }
                    
                }
                completion(arrayCardIssuers)
            } else {
                print("errorrrrrrrrr")
            }
        }
    }
}
