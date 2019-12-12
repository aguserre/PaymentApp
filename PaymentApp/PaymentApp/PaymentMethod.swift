//
//  PaymentMethod.swift
//  PaymentApp
//
//  Created by Agustín Errecalde on 12/12/2019.
//  Copyright © 2019 nistsugaDev.paymentApp. All rights reserved.
//

import Foundation
import ObjectMapper

class PaymentMethod: Mappable {
    var id: String?
    var name: String?
    var paymentTypeId: String?
    var status: String?
    var secureThumbnail: String?
    var thumbnail: String?
    var deferredCapture: String?
    var settings: [Settings]?
    var minAllowedAmount: Int?
    var maxAllowedAmount: Int?
    var accreditationTime: Int?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        paymentTypeId <- map["payment_type_id"]
        status <- map["status"]
        secureThumbnail <- map["secure_thumbnail"]
        thumbnail <- map["thumbnail"]
        deferredCapture <- map["deferred_capture"]
        settings <- map["settings"]
        minAllowedAmount <- map["min_allowed_amount"]
        maxAllowedAmount <- map["min_allowed_amount"]
        accreditationTime <- map["accreditation_time"]
    }
}

class Settings: Mappable{
    var cardNumber: CardNumber?
    var bin: Bin?
    var securityCode: SecurityCode?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        cardNumber <- map["card_number"]
        bin <- map["bin"]
        securityCode <- map["security_code"]
    }
}

class CardNumber: Mappable{
    var validation: String?
    var length: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        validation <- map["validation"]
        length <- map["length"]
    }
}

class Bin: Mappable{
    var pattern: String?
    var installmentsPattern: String?
    var exclusionPattern: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        pattern <- map["pattern"]
        installmentsPattern <- map["installments_pattern"]
        exclusionPattern <- map["exclusion_pattern"]
    }
}

class SecurityCode: Mappable{
    var length: String?
    var cardLocation: String?
    var mode: String?
    
    init(){}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        length <- map["length"]
        cardLocation <- map["card_location"]
        mode <- map["mode"]
    }
    
}
