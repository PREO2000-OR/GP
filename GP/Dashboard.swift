//
//  Dashboard.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

let urlNewOrders = URL(string: "https://maletines.de/orders/newest")!
let urlReadyToDeliverOrders = URL(string: "https://maletines.de/orders/ready-to-deliver")!

struct OrdersAPIResponse: Codable {
    let data: [OrdersData]
}

struct OrdersData: Codable {
    let client_id: Int
    let client_full_name: String
    let client_phone: String
    let order_status_id: Int
    let order_status_description: String
    let address: String
    let description: String
}

struct ProductsData: Codable {
    let unit_id: Int
    let unit_description: String
    let unit_short_time: String
    let product_id: Int
    let product_description: String
}

class Dashboard: UIViewController {
    private var myArray: [OrdersData] = []
    private var myArrayOrdersReady: [OrdersData] = []
    @IBOutlet weak var newOrdersLabel: UILabel!
    @IBOutlet weak var ordersReadyToSend: UILabel!
    @IBOutlet weak var ordersReady: UILabel!
    override func viewDidLoad() {
        myArray = getDataNewOrders(from: urlNewOrders)
        myArrayOrdersReady = getDataOrdersReady(from: urlReadyToDeliverOrders)
        newOrdersLabel.text = String(myArray.count)
        ordersReadyToSend.text = String(myArrayOrdersReady.count)
        ordersReady.text = String(myArrayOrdersReady.count)
        super.viewDidLoad()
    }
    @IBAction func didTapButton(){
        guard let vc = storyboard?.instantiateViewController(identifier: "mainMenu_vc") as? MainMenu else {
            return
        }
        present(vc, animated: true)
    }
}

private func getDataNewOrders(from url: URL) -> [OrdersData] {
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
    //            print(json.data)
    //            print(json.data[0].product_description)
        })
        task.resume()
    }
    semaphore.wait()
    return myArray
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
    //            print(json.data)
    //            print(json.data[0].product_description)
        })
        task.resume()
    }
    semaphore.wait()
    return myArray
}
