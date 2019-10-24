//
//  RegisterModel.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 16/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

struct RegisterModel : Codable {
    let error : Int?
    let error_text : String?
    let user : UserDataModel?
    var token: String?

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case error_text = "error_text"
        case user = "user"
        case token = "token"
    }
}

struct UserDataModel : Codable {
    let id : Int?
    let created : String?
    let updated : String?
    let expiry : String?
    let email : String?
    let phone : String?
    let name : String?
    let status : Int?
    let tiers: String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case created = "created"
        case updated = "updated"
        case expiry = "expiry"
        case email = "email"
        case phone = "phone"
        case name = "name"
        case status = "status"
        case tiers = "tiers"
    }
}

