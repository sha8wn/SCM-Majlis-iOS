//
//  CheckPointModel.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 24/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

struct CheckPointsModel : Codable {
    let error : Int?
    let error_text : String?
    let checkpoints : Checkpoints?

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case error_text = "error_text"
        case checkpoints = "checkpoints"
    }
}

struct Checkpoints : Codable {
    let list : [CheckpointsList]?
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

struct CheckpointsList : Codable {
   let id : Int?
   let created : String?
   let updated : String?
   let event : Int?
   let name : String?
   let hours : String?
   let minutes : String?
   let lat : String?
   let lng : String?
   let checked : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case created = "created"
        case updated = "updated"
        case event = "event"
        case name = "name"
        case hours = "hours"
        case minutes = "minutes"
        case lat = "lat"
        case lng = "lng"
        case checked = "checked"
    }
}
