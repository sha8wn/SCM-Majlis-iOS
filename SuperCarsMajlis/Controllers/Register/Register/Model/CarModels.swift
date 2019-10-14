//
//  CarModel.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 14/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

struct CarModels : Codable {
    let error : Int?
    let error_text : String?
    let models : ModelData?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case error_text = "error_text"
        case models = "models"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Int.self, forKey: .error)
        error_text = try values.decodeIfPresent(String.self, forKey: .error_text)
        models = try values.decodeIfPresent(ModelData.self, forKey: .models)
    }

}

struct ModelData : Codable {
    let list : [ModelList]?
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
        list = try values.decodeIfPresent([ModelList].self, forKey: .list)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        n = try values.decodeIfPresent(Int.self, forKey: .n)
        num_rows = try values.decodeIfPresent(String.self, forKey: .num_rows)
    }
}


struct ModelList : Codable {
    let id : String?
    let created : String?
    let updated : String?
    let display : String?
    let rank : String?
    let brand : String?
    let name : String?
    let img : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case created = "created"
        case updated = "updated"
        case display = "display"
        case rank = "rank"
        case brand = "brand"
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
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        img = try values.decodeIfPresent(String.self, forKey: .img)
    }
}

