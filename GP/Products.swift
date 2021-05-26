//
//  Products.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

class Products: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var myArray: [InventoryData] = []
    @IBOutlet var myTableViewProducts: UITableView!
    
    override func viewDidLoad() {
        //myArray = getData(from: url)
        
        
        super.viewDidLoad()
        myTableViewProducts.register(MyCell.self, forCellReuseIdentifier: "MyCell")
        self.myTableViewProducts.dataSource = self
        self.myTableViewProducts.delegate = self
        self.view.addSubview(self.myTableViewProducts)
//            let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
//            let displayWidth: CGFloat = self.view.frame.width
//            let displayHeight: CGFloat = self.view.frame.height/2.5
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "inventoryEdit_vc") as? InventoryEdit else {
            return
        }
        vc.product_description = myArray[indexPath.row].product_description
        vc.quantity = myArray[indexPath.row].quantity
        vc.category = myArray[indexPath.row].product_id
        vc.id = myArray[indexPath.row].product_id
        vc.unit_id = myArray[indexPath.row].unit_id
        present(vc, animated: true)
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
    cell.textLabel!.text = "\(myArray[indexPath.row].product_description )"
    cell.buttonTapCallback = {
        print("Deleted " + self.myArray[indexPath.row].product_description)
        deleteProduct(id: String(self.myArray[indexPath.row].product_id))
        self.myArray.remove(at: indexPath.row)
        self.myTableViewProducts.reloadData()
    }
        return cell
    }

@IBOutlet var tableView: UITableView!
var dummyData = ["data 0","data 1","data 2"]

@IBAction func didTapButtonCreate(){
    guard let vc = storyboard?.instantiateViewController(identifier: "inventoryCreate_vc") as? InventoryCreate else {
        return
    }
    
    present(vc, animated: true)
}
}
