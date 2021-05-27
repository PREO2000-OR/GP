//
//  ViewController.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

struct loginAPIResponse: Codable {
    let state: String
}

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func didTapButton(){
        let loginResponse = login(name: username.text!, password: password.text!)
        print(loginResponse)
        if loginResponse == "error" {
            print("no pasa")
            let alert = UIAlertController(title: "Error", message: "Credenciales incorrectas", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            guard let vc = storyboard?.instantiateViewController(identifier: "dashboard_vc") as? Dashboard else {
                return
            }
            present(vc, animated: true)
        }
        
    }

}

func login(name: String, password: String) -> String {
    var dataToReturn = "machochin"
    let semaphore = DispatchSemaphore(value: 0)
    DispatchQueue.global().async {
        let url = URL(string:"http://maletines.de/login")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
            
        let params = ["name": name, "password": password] as [String : Any]
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
                
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
                    
            URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                guard let data = data else { return }
                
                var result: loginAPIResponse?
                do {
                    result = try JSONDecoder().decode(loginAPIResponse.self, from: data)
                }
                catch {
                    print("failed to convert")
                }
                dataToReturn = result?.state ?? "lolo"
                semaphore.signal()
            }).resume()
            
//            print(dataToReturn)
        } catch {
            print(error)
        }
        
    }
    
    semaphore.wait()
    return dataToReturn
}
