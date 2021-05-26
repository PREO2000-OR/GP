//
//  Inventory.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

let postUrl = URL(string: "https://maletines.de/products")!
let url = URL(string: "https://maletines.de/inventories")!

struct InventoriesAPIResponse: Codable {
    let data: [InventoryData]
}

struct InventoryData: Codable {

    // MARK: - Properties
    let product_id: Int
    let unit_id: Int
    let product_description: String
    let quantity: String

}



class Inventory: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var myArray: [InventoryData] = []
    
    
    
    @IBOutlet var myTableView: UITableView!

    

        override func viewDidLoad() {
            myArray = getData(from: url)
            
            
            super.viewDidLoad()
            myTableView.register(MyCell.self, forCellReuseIdentifier: "MyCell")
            self.myTableView.dataSource = self
            self.myTableView.delegate = self
            self.view.addSubview(self.myTableView)
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
            self.myTableView.reloadData()
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

class MyCell: UITableViewCell {
    var yourobj : (() -> Void)? = nil

        //You can pass any kind data also.
       //var user: ((String?) -> Void)? = nil

         override func awakeFromNib()
            {
            super.awakeFromNib()
            }
    @IBAction func DeleteButton(_ sender: UIButton) {
        print("Hihihihihi")
        if let btnAction = self.yourobj
                {
                    btnAction()
                  //  user!("pass string")
                }
    }
    
        var buttonTapCallback: () -> ()  = { }

    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Delete", for: .normal)
        btn.backgroundColor = UIColor(red: 216/255, green: 46/255, blue: 12/255, alpha: 1.0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
//
//    let label: UILabel = {
//        let lbl = UILabel()
//        lbl.font = UIFont.systemFont(ofSize: 16)
//        lbl.textColor = .black
//        return lbl
//    }()
//
    @objc func didTapButton() {
        buttonTapCallback()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Add label
        //Add label
//        contentView.addSubview(label)
//        //Set constraints as per your requirements
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 20).isActive = true
//        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
//        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
//        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
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

func deleteProduct(id: String) {
    let semaphore = DispatchSemaphore(value: 0)
    DispatchQueue.global().async {
                guard let url = URL(string: "https://maletines.de/products/" + id) else { return }
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                let session = URLSession.shared
                session.dataTask(with: request) { (data, response, error) in
                    if let response = response {
                        print(response)
                    }
                }.resume()
        semaphore.signal()
    }
    semaphore.wait()
        
}

private func getData(from url: URL) -> [InventoryData] {
    var myArray: [InventoryData] = []
    let semaphore = DispatchSemaphore(value: 0)
    DispatchQueue.global().async {
        let task = URLSession.shared.dataTask(    with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something")
                return
            }
            var result: InventoriesAPIResponse?
            do {
                result = try JSONDecoder().decode(InventoriesAPIResponse.self, from: data)
            }
            catch {
                print("failed to convert")
            }
            
            guard let json = result else {
                return
            }
            myArray = json.data
            semaphore.signal()
    //        self.myArray = json.data
    //        print(self.myArray)
    //            print(json.data)
    //            print(json.data[0].product_description)
        })
        task.resume()
    }
    semaphore.wait()
    return myArray
}



