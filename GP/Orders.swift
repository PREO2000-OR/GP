//
//  Orders.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

let urlAllOrders = URL(string: "https://maletines.de/orders")!

class Orders: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var myArray:[OrdersData] = []
    @IBAction func didTapButtonOrders(){
        guard let vc = storyboard?.instantiateViewController(identifier: "mainMenu_vc") as? MainMenu else {
            return
        }
        present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "ordersDetail_vc") as? OrdersDetail else {
            return
        }
        vc.client_id = myArray[indexPath.row].client_id
        vc.client_full_name = myArray[indexPath.row].client_full_name
        vc.client_phone = myArray[indexPath.row].client_phone
        vc.order_status_id = myArray[indexPath.row].order_status_id
        vc.order_status_description = myArray[indexPath.row].order_status_description
        vc.descriptionOrders = myArray[indexPath.row].description
        vc.address = myArray[indexPath.row].address
        present(vc, animated: true)
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOrders", for: indexPath) as! CellOrders
        cell.textLabel!.text = "\(myArray[indexPath.row].client_full_name )"
        cell.label.text = "3"
            return cell
    }
    
    
    @IBOutlet private var Orders: UITableView!
    override func viewDidLoad() {
        myArray = getDataOrdersReady(from: urlAllOrders)
        super.viewDidLoad()
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
    Orders = UITableView(frame: CGRect(x: 0, y: 100, width: displayWidth, height: displayHeight - barHeight))
    Orders.register(CellOrders.self, forCellReuseIdentifier: "CellOrders")
    Orders.dataSource = self
    Orders.delegate = self
    self.view.addSubview(Orders)
        // Do any additional setup after loading the view.
    }

}

class CellOrders: UITableViewCell {
   
        var buttonTapCallback: () -> ()  = { }

//    let button: UIButton = {
//        let btn = UIButton()
//        btn.setTitle("Delete", for: .normal)
//        btn.backgroundColor = UIColor(red: 216/255, green: 46/255, blue: 12/255, alpha: 1.0)
//        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        return btn
//    }()
////
    let label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .black
        return lbl
    }()
//
    @objc func didTapButton() {
        buttonTapCallback()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //Add label
//        Add label
        contentView.addSubview(label)
        //Set constraints as per your requirements
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        //Add button
//        contentView.addSubview(button)
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//
//        //Set constraints as per your requirements
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
//        button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private func getDataOrdersReady(from url: URL) -> [OrdersData] {
    var myArray: [OrdersData] = []
    let semaphore = DispatchSemaphore(value: 0)
    DispatchQueue.global().async {
        let task = URLSession.shared.dataTask(    with: url, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("something")
                return
            }
            var result: OrdersAPIResponse?
            do {
                result = try JSONDecoder().decode(OrdersAPIResponse.self, from: data)
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
    //            print(j.data)
    //            print(json.data[0].product_description)
        })
        task.resume()
    }
    semaphore.wait()
    return myArray
}
