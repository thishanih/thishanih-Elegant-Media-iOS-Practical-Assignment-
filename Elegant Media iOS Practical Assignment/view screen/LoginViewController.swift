//
//  LoginViewController.swift
//  Elegant Media iOS Practical Assignment
//
//  Created by Thishan Iroshan on 9/9/20.
//  Copyright © 2020 Thishan Iroshan. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var facebookButton: UIButton!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    
    func setUpElements()
           
       {
           // Hide the error label
           errorLabel.alpha = 0
           
           Utilities.styleTextField(emailTextField);
           Utilities.styleTextField(passwordTextField);
           Utilities.styleFilledButton(loginButton);
           Utilities.styleFilledButton(facebookButton);
       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //face book login coding
    
    @IBAction func facebookLogin(_ sender: UIButton) {
        
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
                if let error = error {
                    print("Failed to login: \(error.localizedDescription)")
                    return
                }
                
            guard let accessToken = AccessToken.current else {
                    print("Failed to get access token")
                    return
                }

            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
                
                // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                    if let error = error {
                        print("Login error: \(error.localizedDescription)")
                        let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                        let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(okayAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                        return
                    }
                    
                    // Present the main view
                    if let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") {
                        UIApplication.shared.keyWindow?.rootViewController = homeViewController
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                })

            }
        }
    
    
    @IBAction func loginTapped(_ sender: Any) {
         // TODO: Validate Text Fields
                
                // Create cleaned versions of the text field
                let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                // Signing in the user
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                    
                    if error != nil {
                        // Couldn't sign in
                        self.errorLabel.text = error!.localizedDescription
                        self.errorLabel.alpha = 1
                        
                       
                    }
                    else {
                        
                       let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
                        
                       self.view.window?.rootViewController = homeViewController
                        self.view.window?.makeKeyAndVisible()
                        
                        
                                                
                    }
                }
            }
            
        }

        
        
        
 
