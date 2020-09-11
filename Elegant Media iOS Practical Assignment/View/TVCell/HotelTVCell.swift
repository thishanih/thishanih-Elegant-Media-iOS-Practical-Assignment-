//
//  HotelTVCell.swift
//  movies
//
//  Created by Thishan Iroshan on 9/10/20.
//  Copyright © 2020 Thishan Iroshan. All rights reserved.
//

import Foundation
import UIKit



class HotelTVCell: UITableViewCell {
    
    @IBOutlet weak var hotelTitleLabel: UILabel!
    @IBOutlet weak var hotelDescriptionLabel: UILabel!
    @IBOutlet weak var hotelImage: UIImageView!
    
    func updateUIWithData(with data: HotelDataModel) {
        hotelTitleLabel.text = data.title
        hotelDescriptionLabel.text = data.address
        
    }
    
    
    
}
