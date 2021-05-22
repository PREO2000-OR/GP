//
//  InventoryEdit.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

class InventoryEdit: UIViewController {

    var product_description:String = ""
    var category:Int = 0
    var quantity:String = ""

    @IBOutlet weak var nameTextField:UITextField?
    @IBOutlet weak var categoryTextField:UITextField?
    @IBOutlet weak var quantityTextField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField?.text = product_description
        categoryTextField?.text = String(category)
        quantityTextField?.text = quantity
    }
    @IBAction func didTapButtonEdit(){
        guard let vc = storyboard?.instantiateViewController(identifier: "inventory_vc") as? Inventory else {
            return
        }
        present(vc, animated: true)
    }
}
