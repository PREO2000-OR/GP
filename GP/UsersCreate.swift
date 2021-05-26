//
//  UsersCreate.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

class UsersCreate: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var userPasswordField: UITextField!
    @IBAction func didTapButtonCreate(){
        createUser(name: userNameField.text!, password: userPasswordField.text!, completion: {(error) in
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

func createUser(name: String, password: String, completion: (Error?) -> ()) {
    let semaphore = DispatchSemaphore(value: 0)
    guard let url = URL(string:"http://maletines.de/users/") else { return }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
        
    let params = ["name": name, "password": password] as [String : Any]
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
