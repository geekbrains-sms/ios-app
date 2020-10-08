//
//  CategoryController.swift
//  GeekBrains SMS
//
//  Created by Дмитрий Канский on 07.10.2020.
//  Copyright © 2020 ernokanst. All rights reserved.
//

import UIKit
import Alamofire

class CategoryController: UITableViewController {
    let session = Session.instance
    var data: [String] = []
    struct CatResp: Codable {
        var id: Int
        var title: String
    }
    struct UnitResp: Codable {
        var id: Int
        var title: String
        var description: String
    }
    struct ProductResponse: Codable {
        var id: Int
        var title: String
        var categories: [CatResp]
        var unit: UnitResp
        var image: String?
        var description: String?
    }
    struct FundResponse: Codable {
        var id: Int
        var product: ProductResponse
        var balance: Double
    }
    
    func GetProducts() {
        let session = Session.instance
        let headers: HTTPHeaders = [.authorization(bearerToken: session.token)]
        AF.request("http://46.17.104.250:8189/api/v1/funds", method: .get, headers: headers).responseData { response in
            guard let data = response.value else { return }
            print(response)
            print(data)
            do {
                let decoded = try JSONDecoder().decode([FundResponse].self, from: data)
                print(decoded)
                session.products = decoded
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
        data.append("Все товары")
        for c in session.categoryList { data.append(c) }
        GetProducts()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        cell.textLabel?.text = data[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        session.temp = data[indexPath.row]
        //performSegue(withIdentifier: "selectCategory", sender: nil)
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
