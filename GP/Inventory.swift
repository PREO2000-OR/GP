//
//  Inventory.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit
struct InventoryData: Decodable {

    // MARK: - Properties

    let inventory_id: Int
    let product_id: Int
    let product_description: String
    let quantity: String

}

let url = URL(string: "https://maletines.de/inventories")!

var request = URLRequest(url: url)



class Inventory: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let myArray = [
        [
            "name": "Lucy",
            "category": "Type 1"
        ],
        [
            "name": "John",
            "category": "Type 2"
        ]
    ]
    
    
    @IBOutlet var myTableView: UITableView!

        override func viewDidLoad() {
            super.viewDidLoad()
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        // make sure this JSON is in the format we expect
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        
                    } catch let error as NSError {
                        print("Failed to load: \(error.localizedDescription)")
                    }
                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }
            task.resume()
//            let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
//            let displayWidth: CGFloat = self.view.frame.width
//            let displayHeight: CGFloat = self.view.frame.height/2.5

            myTableView.register(MyCell.self, forCellReuseIdentifier: "MyCell")
            myTableView.dataSource = self
            myTableView.delegate = self
            self.view.addSubview(myTableView)
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let vc = storyboard?.instantiateViewController(identifier: "inventoryEdit_vc") as? InventoryEdit else {
                return
            }
            vc.name = myArray[indexPath.row]["name"] ?? "Not found"
            vc.category = myArray[indexPath.row]["category"] ?? "Not found"
            present(vc, animated: true)
            print("Num: \(indexPath.row)")
            print("Value: \(myArray[indexPath.row])")
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return myArray.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.textLabel!.text = "\(myArray[indexPath.row]["name"] ?? "Not Found")"
            cell.buttonTapCallback = {
                print("Yeiii")
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
    @IBAction func didTapButtonEdit(){
        guard let vc = storyboard?.instantiateViewController(identifier: "inventoryEdit_vc") as? InventoryEdit else {
            return
        }
        present(vc, animated: true)
    }
}

class MyCell: UITableViewCell {
    
    var buttonTapCallback: () -> ()  = { }
    
    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Delete", for: .normal)
        btn.backgroundColor = UIColor(red: 216/255, green: 46/255, blue: 12/255, alpha: 1.0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    
    
    @objc func didTapButton() {
        buttonTapCallback()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Add label
        //Add button
        contentView.addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        //Set constraints as per your requirements
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

