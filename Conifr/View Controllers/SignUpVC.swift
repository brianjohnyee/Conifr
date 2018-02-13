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

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var name: TextField!
    @IBOutlet var email: ErrorTextField!
    @IBOutlet var password: ErrorTextField!
    @IBOutlet var confirmPassword: ErrorTextField!
    
    override func viewDidLoad() {
       // prepareTextFields()
        isMotionEnabled = true
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareTextFields()
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        validateEmail()
        validatePassword()
        
        //HANDLE FIREBASE SIGNIN HERE!!
        //https://firebase.google.com/docs/auth/ios/start?authuser=0
        
    }
}
    
extension SignUpVC {
    
    fileprivate func prepareTextFields(){
        
        name = ErrorTextField()
        name.placeholder = "FUCCKKK"
        name.detail = "Error name"
        name.isClearIconButtonEnabled = true
        name.delegate = self
        name.isPlaceholderUppercasedWhenEditing = true
        name.placeholderAnimation = .default
        name.detailColor = .white
        name.placeholderNormalColor = UIColor.white.withAlphaComponent(0.80)
        
        email = ErrorTextField()
        email.placeholder = "Email"
        email.detail = "Error, incorrect email"
        email.isClearIconButtonEnabled = true
        email.delegate = self
        email.isPlaceholderUppercasedWhenEditing = true
        email.placeholderAnimation = .default
        
        password = ErrorTextField()
        password.placeholder = "Password"
        password.detail = "Incorrect Password"
        password.isClearIconButtonEnabled = true
        password.delegate = self
        password.isPlaceholderUppercasedWhenEditing = true
        password.placeholderAnimation = .default
        
        confirmPassword = ErrorTextField()
        confirmPassword.placeholder = "Confirm Password"
        confirmPassword.detail = "Incorrect confirmed password"
        confirmPassword.isClearIconButtonEnabled = true
        confirmPassword.delegate = self
        confirmPassword.isPlaceholderUppercasedWhenEditing = true
        confirmPassword.placeholderAnimation = .default
        
    }
    
    fileprivate func validateEmail() -> Bool {
        if let emailText = email.text {
            if emailText.isEmpty {
                email.isErrorRevealed  = true
                //email.
                return false
            } else if emailText.contains("@ucsc.edu") {
               return true
            } else {
                email.isErrorRevealed  = true
                return false
            }
        } else {
            return false
        }
    }
    
    fileprivate func validatePassword() -> Bool {
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
}


