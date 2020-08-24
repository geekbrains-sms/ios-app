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
    let session = Session.instance

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
            if self.navigationItem.title == "Изменить пользователя" {
                self.loginInput.text = session.temp
                self.nameInput.text = session.nameData[session.temp]
                self.emailInput.text = session.emailData[session.temp]
                self.phoneInput.text = session.phoneData[session.temp]
                self.roleInput.selectedSegmentIndex = session.roleData[session.temp]!
                self.passwordInput.text = session.loginData[session.temp]
            }
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
            
            if login != "" && password != ""{
                if session.loginList.contains(login) {
                    if self.navigationItem.title != "Изменить пользователя"{
                        let alert = UIAlertController(title: "Ошибка", message: "Пользователь с указанным логином уже существует", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        present(alert, animated: true, completion: nil)
                        return false
                    }
                } else {
                    if self.navigationItem.title == "Изменить пользователя"{
                        session.loginList.remove(at: session.loginList.firstIndex(of: session.temp)!)
                    }
                    session.loginList.append(login)}
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
