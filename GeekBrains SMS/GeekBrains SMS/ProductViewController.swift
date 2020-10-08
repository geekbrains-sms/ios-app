//
//  ProductViewController.swift
//  GeekBrains SMS
//
//  Created by Дмитрий Канский on 08.10.2020.
//  Copyright © 2020 ernokanst. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    let session = Session.instance
    @IBOutlet var name: UIButton!
    @IBOutlet var category: UIButton!
    @IBOutlet var desc: UIButton!
    @IBOutlet var supplier: UILabel!
    @IBOutlet var quantity: UILabel!
    
    override func viewDidLoad() {
        self.navigationItem.title = session.temp
        super.viewDidLoad()
        for p in session.products {
            if p.product.title == session.temp {
                self.name.setTitle(p.product.title, for: .normal)
                self.category.setTitle(p.product.categories[0].title, for: .normal)
                self.desc.setTitle("Описание: " + (p.product.description ?? ""), for: .normal)
                self.supplier.text = """
 Поставщик: ООО "Поставщик"
 """
                self.quantity.text = String(p.balance) + " " + p.product.unit.title
            }
        }

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
