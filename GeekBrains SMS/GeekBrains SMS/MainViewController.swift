//
//  MainViewController.swift
//  GeekBrains SMS
//
//  Created by Дмитрий Канский on 22.08.2020.
//  Copyright © 2020 ernokanst. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let session = Session.instance
        self.navigationItem.title = session.login

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
