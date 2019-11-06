//
//  PromotionModel.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 04/11/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

struct PromotionsModel : Codable {
    let error : Int?
    let error_text : String?
    let promotions : Promotions?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case error_text = "error_text"
        case promotions = "promotions"
    }
}

struct Promotions : Codable {
    let list : [PromotionsList]?
    let limit : Int?
    let n : Int?
    let num_rows : Int?

    enum CodingKeys: String, CodingKey {

        case list = "list"
        case limit = "limit"
        case n = "n"
        case num_rows = "num_rows"
    }
}



struct PromotionsList : Codable {
    let id : Int?
    let created : String?
    let updated : String?
    let display : Int?
    let partner : String?
    let redeemed : String?
    let code : String?
    let name : String?
    let text : String?
    let terms : String?
    let partner_name : String?
    let partner_phone : String?
    let partner_location : String?
    let partner_img : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case created = "created"
        case updated = "updated"
        case display = "display"
        case partner = "partner"
        case redeemed = "redeemed"
        case code = "code"
        case name = "name"
        case text = "text"
        case terms = "terms"
        case partner_name = "partner_name"
        case partner_phone = "partner_phone"
        case partner_location = "partner_location"
        case partner_img = "partner_img"
    }
}
