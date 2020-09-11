//
//  SignUpViewController.swift
//  Elegant Media iOS Practical Assignment
//
//  Created by Thishan Iroshan on 9/9/20.
//  Copyright © 2020 Thishan Iroshan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var conpasswordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
  setUpElements()
        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        errorLabel.alpha = 0;
        
        Utilities.styleTextField(firstNameTextField);
        Utilities.styleTextField(emailTextField);
        Utilities.styleTextField(passwordTextField);
        Utilities.styleTextField(conpasswordTextField);

        Utilities.styleFilledButton(signUpButton);
        
    }

    func validateFields() -> String? {
           
           // Check that all fields are filled in
           if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
               
               return "Please fill in all fields."
           }
           
           // Check if the password is secure
           let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
           if Utilities.isPasswordValid(cleanedPassword) == false {
               // Password isn't secure enough
               return "Please make sure your password is at least 8 characters, contains a special character and a number."
           }
           
           return nil
       }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func signUpTapped(_ sender: Any) {
        
        // Validate the fields
               let error = validateFields()
               
               if error != nil {
                   
                   // There's something wrong with the fields, show error message
                   showError(error!)
               }
               else {
                   
                   // Create cleaned versions of the data
                   let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                
                   let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   
                   let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
                   let profile_photo = "<add_url_here>"
                   // Create the user
                   Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                       
                       // Check for errors
                       if err != nil {
                           
                           // There was an error creating the user
                           self.showError("Error creating user")
                       }
                       else {
                           
                           // User was created successfully, now store the first name and last name
                           let db = Firestore.firestore()
                           
                           db.collection("users").addDocument(data: ["firstname":firstName,
                                                                     "Email":email,
                                                                
                                                                     "profile_photo":profile_photo,
                                                                     "uid": result!.user.uid ]) { (error) in
                               
                               if error != nil {
                                   // Show error message
                                   self.showError("Error saving user data")
                               }
                           }
                           
                           // Transition to the home screen
                           self.transitionToHome()
                       }
                       
                   }
                   
                   
                   
               }
    }
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func transitionToHome() {
           // main staroy controller data pass home storiy board
           
           let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
           
          view.window?.rootViewController = homeViewController
         view.window?.makeKeyAndVisible()
           
           
           
           
           
       }
    
}
