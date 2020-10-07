//
//  ViewController.swift
//  GeekBrains SMS
//
//  Created by Дмитрий Канский on 18.08.2020.
//  Copyright © 2020 ernokanst. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

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
    
    func ServerAuth() {
        let session = Session.instance
        let login = loginInput.text!
        let password = passwordInput.text!
        let parameters: [String: String] = ["password": password, "username": login]
        AF.request("http://192.168.1.72:8189/api/v1/auth", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).responseData { response in
            guard let data = response.value else { return }
            struct LoginResponse: Codable {var token: String}
            do {
                let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
                print(decoded.token)
                session.token = decoded.token
                session.login = login
                self.performSegue(withIdentifier: "login", sender: (Any).self)
            } catch {
                print(error)
                let alert = UIAlertController(title: "Ошибка входа", message: "Возможно, пользователя не существует или пользовательские данные введены некорректно", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
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
        if identifier == "registration" {return true}
        ServerAuth()
        return false
    }
}

