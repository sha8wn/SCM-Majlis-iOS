//
//  CarColors.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 16/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

import Foundation

struct CarColorsModel : Codable {
    let error : Int?
    let error_text : String?
    let colors : CarColors?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case error_text = "error_text"
        case colors = "colors"
    }

}

struct CarColors : Codable {
    let list : [CarColorsList]?
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

struct CarColorsList : Codable {
    let id : Int?
//    let created : String?
//    let updated : String?
//    let display : Int?
//    let rank : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
//        case created = "created"
//        case updated = "updated"
//        case display = "display"
//        case rank = "rank"
        case name = "name"
    }
}
