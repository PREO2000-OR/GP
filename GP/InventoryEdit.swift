//
//  InventoryEdit.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

class InventoryEdit: UIViewController {

    var name:String = ""
    var category:String = ""

    @IBOutlet weak var nameTextField:UITextField?
    @IBOutlet weak var categoryTextField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField?.text = name
        categoryTextField?.text = category
    }
    @IBAction func didTapButtonEdit(){
        guard let vc = storyboard?.instantiateViewController(identifier: "inventory_vc") as? Inventory else {
            return
        }
        present(vc, animated: true)
    }
}
