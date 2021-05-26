//
//  UsersEdit.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

class UsersEdit: UIViewController {

    var name:String = ""
    var id:Int = 0
    var unit_id:Int = 0
    
    @IBOutlet weak var nameTextField:UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField?.text = name
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapButtonEdit(){
        editProduct(name: nameTextField!.text!, id: self.id, completion: {(error) in
                if let error = error {
                    print("Error al crear el objeto")
                    print(error)
                }
            })
        guard let vc = storyboard?.instantiateViewController(identifier: "users_vc") as? Users else {
            return
        }
        present(vc, animated: true)
    }
}



func editProduct(name: String, id: Int, completion: (Error?) -> ()) {
let semaphore = DispatchSemaphore(value: 0)
guard let url = URL(string:"http://maletines.de/users/" + String(id)) else { return }
var urlRequest = URLRequest(url: url)
urlRequest.httpMethod = "PUT"
    
let params = ["name": name] as [String : Any]
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
