//
//  RegisterViewController.swift
//  GeekBrains SMS
//
//  Created by Дмитрий Канский on 19.08.2020.
//  Copyright © 2020 ernokanst. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var loginInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    @IBOutlet var nameInput: UITextField!
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var phoneInput: UITextField!
    @IBOutlet var roleInput: UISegmentedControl!

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            self.loginInput.delegate = self
            self.passwordInput.delegate = self
            self.nameInput.delegate = self
            self.emailInput.delegate = self
            self.phoneInput.delegate = self
            loginInput.tag = 0
            nameInput.tag = 1
            emailInput.tag = 2
            phoneInput.tag = 3
            passwordInput.tag = 4
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
            view.addGestureRecognizer(tap)
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
               nextField.becomeFirstResponder()
            } else {
               textField.resignFirstResponder()
            }
            return false
        }
        
        override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
            let login = loginInput.text!
            let password = passwordInput.text!
            let name = nameInput.text!
            let email = emailInput.text!
            let phone = phoneInput.text!
            let role = roleInput.selectedSegmentIndex
            let session = Session.instance
            
            if login != "" && password != ""{
                session.loginData[login] = password
                session.nameData[login] = name
                session.emailData[login] = email
                session.phoneData[login] = phone
                session.roleData[login] = role
                return true
            } else {
                let alert = UIAlertController(title: "Ошибка", message: "Не введены обязательные данные", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
                return false
            }
        }

    }
