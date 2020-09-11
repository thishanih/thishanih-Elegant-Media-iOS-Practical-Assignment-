//
//  welcomeController.swift
//  Elegant Media iOS Practical Assignment
//
//  Created by Thishan Iroshan on 9/9/20.
//  Copyright © 2020 Thishan Iroshan. All rights reserved.
//loginUpButton
//signUpButton

import UIKit

class welcomeController: UIViewController {
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var loginUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements ()
    }
      
    func setUpElements (){
        
        Utilities.styleFilledButton(signUpButton);
       Utilities.styleHollowButton(loginUpButton);
    }


}

