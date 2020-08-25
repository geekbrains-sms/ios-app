//
//  UserEditor.swift
//  GeekBrains SMS
//
//  Created by Дмитрий Канский on 24.08.2020.
//  Copyright © 2020 ernokanst. All rights reserved.
//

import UIKit

class UserEditor: UITableViewController, UISearchBarDelegate {
    let session = Session.instance
    @IBOutlet var searchBar: UISearchBar!
    var searchActive = false
    var data: [String] = []
    var filteredData: [String] = []
    var loginForNames : [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        for l in session.loginList {
            data.append(session.nameData[l]!)
            filteredData.append(session.nameData[l]!)
            loginForNames[session.nameData[l]!] = l
        }

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "user", for: indexPath)

        cell.textLabel?.text = filteredData[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.navigationItem.title == "Изменить пользователя" {
            session.temp = loginForNames[(self.tableView.cellForRow(at: indexPath)?.textLabel?.text)!]!
        performSegue(withIdentifier: "editUser", sender: nil)
        }
        if self.navigationItem.title == "Удалить пользователя" {
            let alert = UIAlertController(title: "Удаление пользователя", message: "Пользователь \(tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "") будет удалён", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: {action in
                self.session.loginList.remove(at: self.session.loginList.firstIndex(of: (self.tableView.cellForRow(at: indexPath)?.textLabel?.text)!)!)
                self.performSegue(withIdentifier: "deleteDone", sender: nil)
            }))
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
