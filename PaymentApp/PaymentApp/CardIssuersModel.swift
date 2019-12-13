//
//  CardIssuersModel.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 13/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import Foundation
import ObjectMapper

class CardIssuersModel: Mappable {
    var id: String?
    var name: String?
    var paymentTypeId: String?
    var secureThumbnail: String?
    var thumbnail: String?
    var processingMode: String?
    var merchantAccountId: [SettingsModel]?

    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        paymentTypeId <- map["payment_type_id"]
        secureThumbnail <- map["secure_thumbnail"]
        thumbnail <- map["thumbnail"]
        processingMode <- map["processing_mode"]
        merchantAccountId <- map["merchant_account_id"]
    }
}
