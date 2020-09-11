//
//  HotelCloudModel.swift
//  movies
//
//  Created by Thishan Iroshan on 9/10/20.
//  Copyright © 2020 Thishan Iroshan. All rights reserved.
//

import Foundation

struct HotelCloudModel: Decodable {
    var status: Int
    var data: [HotelDataModel]
    
    private enum CodingKeys: String, CodingKey {
        case status, data
    }
}
