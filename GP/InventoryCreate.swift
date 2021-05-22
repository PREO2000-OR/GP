//
//  InventoryCreate.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

class InventoryCreate: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func didTapButtonCreate(){
        guard let vc = storyboard?.instantiateViewController(identifier: "inventory_vc") as? Inventory else {
                return
            }
                
            createProduct(description: "Producto 21", unit_id: 4, completion: {(error) in
                if let error = error {
                    print("Error al crear el objeto")
                    print(error)
                }
            })
                
            present(vc, animated: true)
    }
}

func createProduct(description: String, unit_id: Int, completion: (Error?) -> ()) {
    let semaphore = DispatchSemaphore(value: 0)
        guard let url = URL(string:"http://maletines.de/products") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
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
