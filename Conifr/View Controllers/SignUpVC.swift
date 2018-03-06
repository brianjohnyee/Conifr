//
//  SignUpVC.swift
//  Conifr
//
//  Created by Sid Verma on 2/11/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import Foundation
import UIKit
import Material
import Motion
import Firebase
import FirebaseAuth
import FirebaseDatabase


class SignUpVC: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    
    @IBOutlet var name: TextField!
    @IBOutlet var email: ErrorTextField!
    @IBOutlet var password: ErrorTextField!
    @IBOutlet var confirmPassword: ErrorTextField!
    
    override func viewDidLoad() {
       // prepareTextFields()
        isMotionEnabled = true
        name.detailColor = UIColor.white
        prepareTextFields()
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        //Validate Email and validate password
        if validateEmail() == false {
            let invalidEmail: UIAlertView = UIAlertView(title: "Invalid Email", message: "Your email seems to be invalid",
                                                        delegate: self, cancelButtonTitle: "Ok")
            invalidEmail.show()
        }
        
        if validatePassword() == false {
            let invalidPassword: UIAlertView = UIAlertView(title: "Invalid Password", message: "Your password seems to be invalid",
                                                        delegate: self, cancelButtonTitle: "Ok")
            invalidPassword.show()
            
        }
        
        if validateEmail() && validatePassword() == true {
           
            if let emailText = email.text {
                if let passwordText = password.text {
                    if let nameText = name.text {
                    
                    Auth.auth().createUser(withEmail: emailText, password: passwordText) { (user, error) in
                        
                        let userInfoToDB = ["email" : emailText,
                                            "name": nameText]
                        
                        if let user = user {
                            Database.database().reference(withPath: "users").child(user.uid).updateChildValues(userInfoToDB)
                            UserDefaults.standard.set(user.uid, forKey: "uid")
                            UserDefaults.standard.set(true, forKey: "user_logged_in")
                        } else {
                                print("User errored out")
                            }
                        }
                    }
                }
            }
        }
    }
}
    
extension SignUpVC: TextFieldDelegate {
    
    func prepareTextFields(){
        
        name.placeholder = "Name"
        name.textColor = UIColor.confirOrange()
        name.detailColor = UIColor.confirLightGrey()
        name.placeholderNormalColor = UIColor.confirLightGrey()
        name.placeholderActiveColor = UIColor.confirOrange()
        name.dividerActiveColor = UIColor.confirOrange()
        name.clearIconButton?.tintColor = UIColor.confirOrange()
        
        email.placeholder = "Email"
        email.textColor = UIColor.confirOrange()
        email.detailColor = UIColor.confirLightGrey()
        email.placeholderNormalColor = UIColor.confirLightGrey()
        email.placeholderActiveColor = UIColor.confirOrange()
        email.dividerActiveColor = UIColor.confirOrange()
        email.clearIconButton?.tintColor = UIColor.confirOrange()
        
        password.placeholder = "Password"
        password.textColor = UIColor.confirOrange()
        password.detailColor = UIColor.confirLightGrey()
        password.placeholderNormalColor = UIColor.confirLightGrey()
        password.placeholderActiveColor = UIColor.confirOrange()
        password.dividerActiveColor = UIColor.confirOrange()
        password.clearIconButton?.tintColor = UIColor.confirOrange()
        
        confirmPassword.placeholder = "Confirm Password"
        confirmPassword.textColor = UIColor.confirOrange()
        confirmPassword.detailColor = UIColor.confirLightGrey()
        confirmPassword.placeholderNormalColor = UIColor.confirLightGrey()
        confirmPassword.placeholderActiveColor = UIColor.confirOrange()
        confirmPassword.dividerActiveColor = UIColor.confirOrange()
        confirmPassword.clearIconButton?.tintColor = UIColor.confirOrange()
        
        name.isClearIconButtonEnabled = true
        name.isPlaceholderUppercasedWhenEditing = false
        name.placeholderAnimation = .default
        name.delegate = self

        email.isClearIconButtonEnabled = true
        email.isPlaceholderUppercasedWhenEditing = false
        email.placeholderAnimation = .default
        email.delegate = self
        
        password.isClearIconButtonEnabled = true
        password.isPlaceholderUppercasedWhenEditing = false
        password.placeholderAnimation = .default
        password.isSecureTextEntry = true
        password.delegate = self
        
        
        confirmPassword.isClearIconButtonEnabled = true
        confirmPassword.isPlaceholderUppercasedWhenEditing = false
        confirmPassword.isSecureTextEntry = true
        confirmPassword.placeholderAnimation = .default
        confirmPassword.delegate = self
        
    }
    
    public func validateEmail() -> Bool {
        if let emailText = email.text {
            if emailText.contains("@"){
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    public func validatePassword() -> Bool {
        if let passwordText = password.text {
            if let confirmPasswordText = confirmPassword.text {
                if passwordText == confirmPasswordText {
                    return true
                }
            } else {
               return false
            }
        } else {
            return false
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}



extension UIColor {
    static func confirOrange() -> UIColor{
        return UIColor(red:255/255.0, green:149/255.0, blue:0/255.0,  alpha:1)
    }
    static func confirLightGrey() -> UIColor{
       return UIColor(red:216/255.0, green:216/255.0, blue:216/255.0,  alpha:1)
    }
}

