//
//  HomeModel.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 23/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation

struct HomeModel : Codable {
    let error : Int?
    let error_text : String?
    let events : HomeEvents?

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case error_text = "error_text"
        case events = "events"
    }
}

struct HomeEvents : Codable {
    let list : [HomeList]?
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


struct HomeList : Codable {
    let id : Int?
    let created : String?
    let updated : String?
    let display : Int?
    let date : String?
    let start : String?
    let end : String?
    let limit_cars : Int?
    let limit_guests : Int?
    let fee : Int?
    let location : String?
    let tiers : String?
    let partners : [HomePartners]?
    let name : String?
    let text : String?
    let img : String?
    let reservation : Int?
    let status : String?
    let users : [HomeUsers]?
    let brands : [HomeBrands]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case created = "created"
        case updated = "updated"
        case display = "display"
        case date = "date"
        case start = "start"
        case end = "end"
        case limit_cars = "limit_cars"
        case limit_guests = "limit_guests"
        case fee = "fee"
        case location = "location"
        case tiers = "tiers"
        case partners = "partners"
        case name = "name"
        case text = "text"
        case img = "img"
        case reservation = "reservation"
        case status = "status"
        case users = "users"
        case brands = "brands"
    }
}

struct HomeUsers : Codable {
    let id : Int?
    let name : String?
    let img : String?
    let guests : Int?
    let brand_name : String?
    let model_name : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case img = "img"
        case guests = "guests"
        case brand_name = "brand_name"
        case model_name = "model_name"
    }
}

struct HomeBrands : Codable {
    let id : Int?
    let name : String?
    let img : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case img = "img"
    }
}

struct HomePartners : Codable {
    let id : Int?
    let name : String?
    let img : String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case img = "img"
    }
}
