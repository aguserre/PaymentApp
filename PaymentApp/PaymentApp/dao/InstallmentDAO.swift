//
//  InstallmentDAO.swift
//  PaymentApp
//
//  Created by Agustin Errecalde on 14/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit
import Alamofire

class InstallmentDAO {
    
    func getInstallments(parameters: [String: Any] ,completion: @escaping ([InstallmentModel]) -> Void) {
        Alamofire.request(INSTALLMENTS, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let json = response.result.value as? [[String: Any]] {
                var arrayInstallments = [InstallmentModel]()
                
                for jsonInstallments in json{
                    if let installmentObject = InstallmentModel(JSON: jsonInstallments) {
                        arrayInstallments.append(installmentObject)
                    }
                    
                }
                completion(arrayInstallments)
            } else {
                print("errorrrrrrrrr")
            }
        }
    }
}
