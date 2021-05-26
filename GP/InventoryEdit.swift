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
    var id:Int = 0
    var unit_id:Int = 0

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
        editProduct(description: nameTextField!.text!, id: self.id, unit_id: self.unit_id, completion: {(error) in
                if let error = error {
                    print("Error al crear el objeto")
                    print(error)
                }
            })
        guard let vc = storyboard?.instantiateViewController(identifier: "inventory_vc") as? Inventory else {
            return
        }
        present(vc, animated: true)
    }
}

func editProduct(description: String, id: Int, unit_id: Int, completion: (Error?) -> ()) {
    let semaphore = DispatchSemaphore(value: 0)
    guard let url = URL(string:"http://maletines.de/products/" + String(id)) else { return }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "PUT"
        
    let params = ["description": description, "unit_id": unit_id] as [String : Any]
    do {
        let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            
        urlRequest.httpBody = data
        urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
                
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8))
        }).resume()
            
    } catch {
        completion(error)
    }
    semaphore.signal()
    semaphore.wait()
}
