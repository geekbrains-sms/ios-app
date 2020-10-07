//
//  RegisterViewController.swift
//  GeekBrains SMS
//
//  Created by Дмитрий Канский on 19.08.2020.
//  Copyright © 2020 ernokanst. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var loginInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    @IBOutlet var nameInput: UITextField!
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var phoneInput: UITextField!
    @IBOutlet var roleInput: UISegmentedControl!
    @IBOutlet var surnameInput: UITextField!
    let session = Session.instance
    let rolesID = [1:"ROLE_CUSTOMER", 2:"ROLE_MANAGER", 3:"ROLE_ADMIN"]
    
    func GetUserData() {
        let headers: HTTPHeaders = [.authorization(bearerToken: session.token)]
        AF.request("http://46.17.104.250:8189/api/v1/users/"+String(session.loginID[session.temp]!), method: .get, headers: headers).responseData { response in
            guard let data = response.value else { return }
            struct Roles: Codable {
                var id: Int
                var name: String
            }
            struct UserResponse: Codable {
                var login: String
                var firstname: String
                var lastname: String
                var phone: String
                var email: String
                var roles: [Roles]
            }
            do {
                let decoded = try JSONDecoder().decode(UserResponse.self, from: data)
                print(decoded)
                self.loginInput.text = self.session.temp
                self.nameInput.text = decoded.firstname
                self.surnameInput.text = decoded.lastname
                self.emailInput.text = decoded.email
                self.phoneInput.text = decoded.phone
                var maxrole = 1
                for role in decoded.roles {
                    if role.id > maxrole { maxrole = role.id }
                }
                self.roleInput.selectedSegmentIndex = maxrole - 1
            } catch {
                print(error)
                let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            self.loginInput.delegate = self
            self.passwordInput.delegate = self
            self.nameInput.delegate = self
            self.surnameInput.delegate = self
            self.emailInput.delegate = self
            self.phoneInput.delegate = self
            loginInput.tag = 0
            nameInput.tag = 1
            surnameInput.tag = 2
            emailInput.tag = 3
            phoneInput.tag = 4
            passwordInput.tag = 5
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
            view.addGestureRecognizer(tap)
            if self.navigationItem.title == "Изменить пользователя" {
                GetUserData()
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
            let surname = surnameInput.text!
            let email = emailInput.text!
            let phone = phoneInput.text!
            let role = roleInput.selectedSegmentIndex + 1
            
                //let parameters = ["email": email, "firstname": name, "lastname": surname, "login": login, "password": password, "phone": phone, "roles": ["id": role, "name": rolesID[role]!]] as! [String : Encodable]
                struct Roles: Codable {
                    var id: Int
                    var name: String
                }
                struct UserResponse: Codable {
                    var email: String
                    var firstname: String
                    var lastname: String
                    var login: String
                    var password: String
                    var phone: String
                    var roles: [Roles]
                }
                let currentRole = Roles(id: role, name: rolesID[role]!)
                let currentUser = UserResponse(email: email, firstname: name, lastname: surname, login: login, password: password, phone: phone, roles: [currentRole])
                let parameters = try! JSONEncoder().encode(currentUser)
                let headers: HTTPHeaders = [.authorization(bearerToken: session.token)]
            if self.navigationItem.title == "Изменить пользователя"{
                AF.request("http://46.17.104.250:8189/api/v1/users/"+String(session.loginID[session.temp]!), method: .put, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseData { response in print(response) }
                return true
            } else {
                AF.request("http://46.17.104.250:8189/api/v1/users/", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseData { response in print(response) }
                return true
            }
        }

    }
