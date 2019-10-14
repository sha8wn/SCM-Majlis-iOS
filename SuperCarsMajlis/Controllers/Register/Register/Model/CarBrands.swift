//
//  CarBrands.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 11/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

struct CarBrands : Codable {
    
    let error : Int?
    let error_text : String?
    let brands : BrandsData?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case error_text = "error_text"
        case brands = "brands"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Int.self, forKey: .error)
        error_text = try values.decodeIfPresent(String.self, forKey: .error_text)
        brands = try values.decodeIfPresent(BrandsData.self, forKey: .brands)
    }

}

struct BrandsData : Codable {
    let list : [BrandList]?
    let limit : Int?
    let n : Int?
    let num_rows : String?

    enum CodingKeys: String, CodingKey {

        case list = "list"
        case limit = "limit"
        case n = "n"
        case num_rows = "num_rows"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        list = try values.decodeIfPresent([BrandList].self, forKey: .list)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        n = try values.decodeIfPresent(Int.self, forKey: .n)
        num_rows = try values.decodeIfPresent(String.self, forKey: .num_rows)
    }

}

struct BrandList : Codable {
    let id : String?
    let created : String?
    let updated : String?
    let display : String?
    let rank : String?
    let name : String?
    let img : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case created = "created"
        case updated = "updated"
        case display = "display"
        case rank = "rank"
        case name = "name"
        case img = "img"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        updated = try values.decodeIfPresent(String.self, forKey: .updated)
        display = try values.decodeIfPresent(String.self, forKey: .display)
        rank = try values.decodeIfPresent(String.self, forKey: .rank)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        img = try values.decodeIfPresent(String.self, forKey: .img)
    }

}
