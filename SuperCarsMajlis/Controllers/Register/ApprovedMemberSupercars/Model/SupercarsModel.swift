//
//  SupercarsModel.swift
//  SuperCarsMajlis
//
//  Created by Himanshu Goyal on 01/10/19.
//  Copyright © 2019 Ongraph Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit

struct SupercarsModel {
    var car_Id: String?
    var brand: String?
    var brand_Id: Int?
    var model: String?
    var model_Id: Int?
    var color: String?
    var color_Id: Int?
    var carRegistraionFrontImage: UIImage?
    var carRegistraionBackImage: UIImage?
    var carImage: UIImage?
    var carRegistraionFrontImageURL: String?
    var carRegistraionBackImageURL: String?
    var carImageURL: String?
    var isCarRegistraionFrontImageEdit: Bool?
    var isCarRegistraionBackImageEdit: Bool?
    var isCarImageEdit: Bool?
    var carRegistraionFront_Id: String?
    var carRegistraionBack_Id: String?
    var carImage_Id: String?
    var deleted_Car_Array: [String]?
    var deleted_Doc_Array: [String]?
}

struct SuperCars_Model : Codable {
    let error : Int?
    let error_text : String?
    let cars : SuperCars?

    enum CodingKeys: String, CodingKey {
        case error = "error"
        case error_text = "error_text"
        case cars = "cars"
    }
}

struct SuperCars : Codable {
    let list : [SuperCarsList]?
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

struct SuperCarsList : Codable {
    let id : Int?
    let created : String?
    let updated : String?
    let user : Int?
    let brand : Int?
    let model : Int?
    let color : Int?
    let imgs : [ImageModel]?
    let docs : [ImageModel]?
    let model_name : String?
    let model_img : String?
    let brand_name : String?
    let brand_img : String?
    let color_name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case created = "created"
        case updated = "updated"
        case user = "user"
        case brand = "brand"
        case model = "model"
        case color = "color"
        case imgs = "imgs"
        case docs = "docs"
        case model_name = "model_name"
        case model_img = "model_img"
        case brand_name = "brand_name"
        case brand_img = "brand_img"
        case color_name = "color_name"
    }
}

struct ImageModel : Codable {
    let n : Int?
    let img : String?

    enum CodingKeys: String, CodingKey {

        case n = "n"
        case img = "img"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        n = try values.decodeIfPresent(Int.self, forKey: .n)
        img = try values.decodeIfPresent(String.self, forKey: .img)
    }

}
