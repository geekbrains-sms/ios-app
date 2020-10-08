//
//  MainViewController.swift
//  GeekBrains SMS
//
//  Created by Дмитрий Канский on 22.08.2020.
//  Copyright © 2020 ernokanst. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UITabBarController {
    func GetUsers() {
        let session = Session.instance
        let headers: HTTPHeaders = [.authorization(bearerToken: session.token)]
        AF.request("http://46.17.104.250:8189/api/v1/users", method: .get, headers: headers).responseData { response in
            guard let data = response.value else { return }
            struct UserResponse: Codable {
                var id: Int
                var login: String
                var firstname: String
                var lastname: String
            }
            do {
                let decoded = try JSONDecoder().decode([UserResponse].self, from: data)
                print(decoded)
                session.loginList = []
                session.loginID = [:]
                session.nameData = [:]
                for p in decoded {
                    session.loginList.append(p.login)
                    session.loginID[p.login] = p.id
                    session.nameData[p.login] = p.firstname + " " + p.lastname
                }
            } catch {
                print(error)
                let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func GetCategories() {
        let session = Session.instance
        let headers: HTTPHeaders = [.authorization(bearerToken: session.token)]
        AF.request("http://46.17.104.250:8189/api/v1/categories", method: .get, headers: headers).responseData { response in
            guard let data = response.value else { return }
            struct CategoryResponse: Codable {
                var id: Int
                var title: String
            }
            do {
                let decoded = try JSONDecoder().decode([CategoryResponse].self, from: data)
                print(decoded)
                session.categoryList = []
                session.categoryID = [:]
                for c in decoded {
                    session.categoryList.append(c.title)
                    session.categoryID[c.title] = c.id
                }
            } catch {
                print(error)
                let alert = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func GetContractors() {
        let session = Session.instance
        let headers: HTTPHeaders = [.authorization(bearerToken: session.token)]
        AF.request("http://46.17.104.250:8189/api/v1/contractors", method: .get, headers: headers).responseData { response in
            guard let data = response.value else { return }
            struct ContractorResponse: Codable {
                var id: Int
                var title: String
            }
            do {
                let decoded = try JSONDecoder().decode([ContractorResponse].self, from: data)
                print(decoded)
                session.contractorList = []
                session.contractorID = [:]
                for c in decoded {
                    session.contractorList.append(c.title)
                    session.contractorID[c.title] = c.id
                }
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
        let session = Session.instance
        self.navigationItem.title = session.login
        GetUsers()
        GetCategories()
        GetContractors()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
