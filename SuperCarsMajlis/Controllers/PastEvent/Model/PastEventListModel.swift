//
//  PastEventListModel.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 11/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

struct PastEventListModel : Codable {
    let error : Int?
    let error_text : String?
    let past_events : Past_events?

    enum CodingKeys: String, CodingKey {

        case error = "error"
        case error_text = "error_text"
        case past_events = "past_events"
    }

}

struct PastEventImages : Codable {
    let n : Int?
    let img : String?

    enum CodingKeys: String, CodingKey {

        case n = "n"
        case img = "img"
    }

}

struct PastEventList : Codable {
    let id : Int?
    let created : String?
    let updated : String?
    let display : Int?
    let date : String?
    let participants : String?
    let location : String?
    let name : String?
    let text : String?
    let imgs : [PastEventImages]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case created = "created"
        case updated = "updated"
        case display = "display"
        case date = "date"
        case participants = "participants"
        case location = "location"
        case name = "name"
        case text = "text"
        case imgs = "imgs"
    }
}

struct Past_events : Codable {
    let list : [PastEventList]?
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
