//
//  TrackerInfoViewController.swift
//  SampleTest
//
//  Created by Mac HD on 24/10/19.
//  Copyright © 2019 HMSPL. All rights reserved.
//

import UIKit

class TrackerInfoViewController: BaseViewController {
    
    @IBOutlet weak var txtfieldFirstName: UITextField!
    @IBOutlet weak var txtfieldLastName: UITextField!
    @IBOutlet weak var txtfieldEmail: UITextField!
    @IBOutlet weak var scrollview: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
    }
    
    func configureData() {
        txtfieldFirstName.delegate = self
        txtfieldLastName.delegate = self
        txtfieldEmail.delegate = self
        addKeypadDismiss()
    }
    
    func addKeypadDismiss() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func validateInputFields(fName: String, lName: String, email: String) -> Bool {
        
        var isPass: Bool = false
        
        if fName.isEmpty {
            self.showAlertMessage(message: " FirstName \(AlertConstant.nameEmpty)")
        }
        else if ((fName.count < 2 || fName.count > 15)) {
            self.showAlertMessage(title: "First Name", message: AlertConstant.validName, completionHandler: nil)
        }
        else if lName.isEmpty {
            self.showAlertMessage(message: " LastName \(AlertConstant.nameEmpty)")
        }
        else if (lName.count < 2 || lName.count > 15)
        {
            self.showAlertMessage(title: "Last Name", message: AlertConstant.validName, completionHandler: nil)
        }
        else if email.isEmpty {
            self.showAlertMessage(message: " Email \(AlertConstant.nameEmpty)")
        }
        else if !isValidEmail(emailStr: email)
        {
            self.showAlertMessage(message: AlertConstant.email)
        }
        else {
            isPass = true
        }
        
        return isPass
        
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        
        if validateInputFields(fName: txtfieldFirstName.text ?? "", lName: txtfieldLastName.text ?? "", email: txtfieldEmail.text ?? "") {
            showToast(message: "Success")
        }
        else {
            print("Input validation failed")
        }
        
    }

}

extension TrackerInfoViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField
        {
        case txtfieldFirstName:
            txtfieldLastName.becomeFirstResponder()
        case txtfieldLastName:
            txtfieldEmail.becomeFirstResponder()
        case txtfieldEmail:
            txtfieldEmail.resignFirstResponder()
        default:
            print("none")
        }
        
        return true
    }
}
