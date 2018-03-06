//
//  tellUsAboutYourselfVC.swift
//  Conifr
//
//  Created by Sid Verma on 2/24/18.
//  Copyright © 2018 Sid Verma. All rights reserved.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0
import Firebase

class tellUsAboutYourselfVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var affiliationTextField: UITextField!
    @IBOutlet weak var collegeTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var studentYear: UITextField!
    
    var collegeList = ["Kresge", "College Ten", "College 9", "Rachel Carson", "Oakes", "Porter", "Merrill", "Cowell", "Crown", "Stevenson"]
    
    var affiliationList = ["Student", "Faculty", "Staff"]
    
    var standingList = ["Freshmen", "Sophomore", "Junior", "Senior", "Graduate"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageTextField.delegate = self
        hideKeyboardWhenTappedAround()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func affiliationTextFieldDidBeginEditing(_ sender: Any) {
        self.affiliationTextField.resignFirstResponder()
        self.ageTextField.resignFirstResponder()
        self.ageTextField.endEditing(true)
        ActionSheetMultipleStringPicker.show(withTitle: "Account Type", rows: [
            affiliationList
            ], initialSelection: [0], doneBlock: {
                picker, indexes, values in
                self.affiliationTextField.text = values.debugDescription.lines[1]
                
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }

    @IBAction func collegeListTextFieldTextFieldDidBeginEditing(_ sender: Any) {
        self.collegeTextField.resignFirstResponder()
        self.ageTextField.resignFirstResponder()
        self.ageTextField.endEditing(true)
        ActionSheetMultipleStringPicker.show(withTitle: "College Affiliations", rows: [
            collegeList
            ], initialSelection: [0], doneBlock: {
                picker, indexes, values in
                self.collegeTextField.text = values.debugDescription.lines[1]
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func studentYearDidBeginEditing(_ sender: Any) {
        self.studentYear.resignFirstResponder()
        self.ageTextField.resignFirstResponder()
        self.ageTextField.endEditing(true)
        ActionSheetMultipleStringPicker.show(withTitle: "Year", rows: [
            standingList
            ], initialSelection: [0], doneBlock: {
                picker, indexes, values in
                self.studentYear.text = values.debugDescription.lines[1]
                return
        }, cancel: { ActionMultipleStringCancelBlock in return }, origin: sender)
    }
    
    
    @IBAction func signUp(_ sender: Any){
        let ageNotANumber: UIAlertView = UIAlertView(title: "Age Invalid", message: "Your age seems to be invalid",
                                                     delegate: self, cancelButtonTitle: "Ok")
        //Validate that the age is numbers only
        if !(collegeTextField.text?.isEmpty)! {
            if !(affiliationTextField.text?.isEmpty)! {
            if let age = ageTextField.text as? NSString {
                if let ageInt = age.integerValue as? Int {
                    if ageInt >= 17 {
                        
                       //Roll Tide
                        if let uid = UserDefaults.standard.string(forKey: "uid"){
                            Database.database().reference(withPath: "users").child(uid).updateChildValues(
                                ["uid": uid,
                                "college": collegeTextField.text,
                                "account_type": affiliationTextField.text,
                                "age": ageTextField.text,
                                "year": studentYear.text])
                            
                            let nav = storyboard?.instantiateViewController(withIdentifier: "nav")
                            self.present(nav!, animated: true, completion: nil)
                        } else {
                            ageNotANumber.show()
                        }
                    } else {ageNotANumber.show()}
                } else {ageNotANumber.show()}
            } else {ageNotANumber.show()}
            } else {ageNotANumber.show()}
        } else {ageNotANumber.show()}
    }
    
    
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
