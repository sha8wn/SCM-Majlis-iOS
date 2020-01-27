//
//  ApprovedMemberDetailModel.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 16/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//


import Foundation

struct ApprovedMemberDetailModel : Codable {
    let error : Int?
    let error_text : String?
    let users : ApprovedUsers?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case error_text = "error_text"
        case users = "users"
    }

}

struct ApprovedUsers : Codable {
    let list : [ApprovedUsersList]?
//    let limit : Int?
//    let n : Int?
//    let num_rows : Int?

    enum CodingKeys: String, CodingKey {

        case list = "list"
//        case limit = "limit"
//        case n = "n"
//        case num_rows = "num_rows"
    }

}


struct ApprovedUsersList : Codable {
    let id : Int?
    let id2: String?
    let created : String?
    let expiry : String?
    let name : String?
    let email : String?
    let phone : String?
    let tiers : String?
//    let status : String?
    let img : String?
    let docs : [Docs]?
    let licenses : [Licenses]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case id2 = "id2"
        case created = "created"
        case expiry = "expiry"
        case name = "name"
        case email = "email"
        case phone = "phone"
        case tiers = "tiers"
        case img = "img"
        case docs = "docs"
        case licenses = "licenses"
    }

}


struct Licenses : Codable {
    let n : Int?
    let img : String?

    enum CodingKeys: String, CodingKey {

        case n = "n"
        case img = "img"
    }

}

struct Docs : Codable {
    let n : Int?
    let img : String?

    enum CodingKeys: String, CodingKey {

        case n = "n"
        case img = "img"
    }

}
