//
//  HotelDataModel.swift
//  movies
//
//  Created by Thishan Iroshan on 9/10/20.
//  Copyright © 2020 Thishan Iroshan. All rights reserved.
//

import Foundation

struct HotelDataModel: Decodable {
    var id: Int
    var title: String
    var description: String
    var address: String
    var image: ImageDataModel
    
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, address, image
    }
}
