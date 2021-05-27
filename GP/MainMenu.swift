//
//  MainMenu.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

class MainMenu: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func didTapButtonInventory(){
        guard let vc = storyboard?.instantiateViewController(identifier: "inventory_vc") as? Inventory else {
            return
        }
        present(vc, animated: true)
    }
    @IBAction func didTapButtonOrders(){
        guard let vc = storyboard?.instantiateViewController(identifier: "orders_vc") as? Orders else {
            return
        }
        present(vc, animated: true)
    }
    @IBAction func didTapButtonCurrentOrders(){
        guard let vc = storyboard?.instantiateViewController(identifier: "currentOrders_vc") as? CurrentOrders else {
            return
        }
        present(vc, animated: true)
    }
    @IBAction func didTapButtonUsers(){
        guard let vc = storyboard?.instantiateViewController(identifier: "users_vc") as? Users else {
            return
        }
        present(vc, animated: true)
    }
    @IBAction func didTapButtonProducts(){
        guard let vc = storyboard?.instantiateViewController(identifier: "products_vc") as? Products else {
            return
        }
        present(vc, animated: true)
    }
    @IBAction func didTapButtonDashboard(){
        guard let vc = storyboard?.instantiateViewController(identifier: "dashboard_vc") as? Dashboard else {
            return
        }
        
        present(vc, animated: true)
    }
    @IBAction func didTapButtonCatalogue(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let balanceViewController = storyBoard.instantiateViewController(withIdentifier: "ivc") as! InventoryViewController
        self.present(balanceViewController, animated: true, completion: nil)
    }
}
