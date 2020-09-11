//
//  DetailViewController.swift
//  Elegant Media iOS Practical Assignment
//
//  Created by Thishan Iroshan on 9/10/20.
//  Copyright © 2020 Thishan Iroshan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var titleLb1: UILabel!
        @IBOutlet weak var dceLb1: UILabel!
        
        var hotel:HotelDataModel?
        
        override func viewDidLoad() {
            super.viewDidLoad()

            titleLb1.text = hotel?.title
            dceLb1.text = hotel?.description
            
            
            
        }
        

        

    }

    
