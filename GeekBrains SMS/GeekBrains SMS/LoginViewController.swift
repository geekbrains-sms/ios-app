//
//  ViewController.swift
//  GeekBrains SMS
//
//  Created by Дмитрий Канский on 18.08.2020.
//  Copyright © 2020 ernokanst. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var loginInput: UITextField!
    @IBOutlet var passwordInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.loginInput.delegate = self
        self.passwordInput.delegate = self
        loginInput.tag = 0
        passwordInput.tag = 1
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
        
        if login == "login" && password == "password" {
            return true
        } else {
            let alert = UIAlertController(title: "Ошибка", message: "Учётная запись не найдена", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return false
        }
    }

}

