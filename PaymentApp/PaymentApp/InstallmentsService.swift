//
//  InstallmentsService.swift
//  PaymentApp
//
//  Created by Agustin Errecalde on 14/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import UIKit

class InstallmentsService {
    
    func getInstallments(parameters:[String:Any], completion: @escaping (InstallmentModel) -> Void) {
        let dao = InstallmentDAO()
        dao.getInstallments(parameters: parameters) { (installment) in
            completion(installment)
        }
    }
}
