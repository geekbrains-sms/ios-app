//
//  ProductController.swift
//  GeekBrains SMS
//
//  Created by Дмитрий Канский on 24.08.2020.
//  Copyright © 2020 ernokanst. All rights reserved.
//

import UIKit

class ProductController: UITableViewController, UISearchBarDelegate {
    let session = Session.instance
    @IBOutlet var searchBar: UISearchBar!
    var searchActive = false
    var data: [String] = []
    var filteredData: [String] = []
    
    override func viewDidLoad() {
        self.navigationItem.title = session.temp
        super.viewDidLoad()
        searchBar.delegate = self
        if session.temp == "Все товары"{
        for l in session.products {
            data.append(l.product.title)
            filteredData.append(l.product.title)
        }} else {
            for l in session.products {
                if l.product.categories[0].title == session.temp{
                data.append(l.product.title)
                    filteredData.append(l.product.title)}}}

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
        return filteredData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)

        cell.textLabel?.text = filteredData[indexPath.row]
        for l in session.products { if l.product.title==cell.textLabel?.text {
            cell.detailTextLabel?.text = String(l.balance) + " " + l.product.unit.title
        }}

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        session.temp = filteredData[indexPath.row]
        //performSegue(withIdentifier: "editUser", sender: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
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
