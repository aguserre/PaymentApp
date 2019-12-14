//
//  InstallmentModel.swift
//  PaymentApp
//
//  Created by Agustin Errecalde on 14/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import Foundation
import ObjectMapper

class InstallmentModel: Mappable {
    var paymentMethodId: String?
    var paymentTypeId: String?
    var issuer: Issuer?
    var processingMode: String?
    var merchantAccountId: String?
    var payerCosts: [PlayerCosts]?

    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        paymentMethodId <- map["payment_method_id"]
        paymentTypeId <- map["payment_type_id"]
        issuer <- map["issuer"]
        processingMode <- map["processing_mode"]
        merchantAccountId <- map["merchant_account_id"]
        payerCosts <- map["payer_costs"]
    }
}

class Issuer : Mappable {
    var id: String?
    var name: String?
    var secureThumbnail: String?
    var thumbnail: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        secureThumbnail <- map["secure_thumbnail"]
        thumbnail <- map["thumbnail"]
    }
}

class PlayerCosts : Mappable {
    var installments: Int?
    var installmentRate: String?
    var discountRate: String?
    var reimbursementRate: String?
    var labels: [String]?
    var installmentRateCollector: [String]?
    var minAllowedAmount: Double?
    var maxAllowedAmount: Double?
    var recommendedMessage: String?
    var installmentAmount: Double?
    var totalAmount: Double?
    var paymentMethodOptionId: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        installments <- map["installments"]
        installmentRate <- map["installment_rate"]
        discountRate <- map["discount_rate"]
        reimbursementRate <- map["reimbursement_rate"]
        labels <- map["labels"]
        installmentRateCollector <- map["installment_rate_collector"]
        minAllowedAmount <- map["min_allowed_amount"]
        maxAllowedAmount <- map["max_allowed_amount"]
        recommendedMessage <- map["recommended_message"]
        installmentAmount <- map["installment_amount"]
        totalAmount <- map["total_amount"]
        paymentMethodOptionId <- map["payment_method_option_id"]
    }
}
