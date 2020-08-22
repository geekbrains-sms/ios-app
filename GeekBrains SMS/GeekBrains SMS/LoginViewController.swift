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
        if identifier == "registration" {return true}
        let login = loginInput.text!
        let password = passwordInput.text!
        let session = Session.instance
        
        if session.loginData.keys.contains(login) {
            if session.loginData[login] == password {
                return true } else {return false}
        } else {
            let alert = UIAlertController(title: "Пользователь с такими логином и паролем не найден", message: "Возможно, пользователя не существует или пользовательские данные введены некорректно", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            return false
        }
    }

}

