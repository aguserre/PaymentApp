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
        id <- map["card_number"]
        name <- map["bin"]
        paymentTypeId <- map["security_code"]
        status <- map["card_number"]
        secureThumbnail <- map["bin"]
        thumbnail <- map["security_code"]
        deferredCapture <- map["card_number"]
        settings <- map["bin"]
        minAllowedAmount <- map["security_code"]
        maxAllowedAmount <- map["card_number"]
        accreditationTime <- map["bin"]
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
