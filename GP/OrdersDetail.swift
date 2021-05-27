//
//  OrdersDetail.swift
//  GP
//
//  Created by Oswaldo Osuna on 26/05/21.
//

import UIKit

class OrdersDetail: UIViewController {
    
    var client_id: Int = 0
    var client_full_name: String = ""
    var client_phone: String = ""
    var order_status_id: Int = 0
    var order_status_description: String = ""
    var address: String = ""
    var descriptionOrders: String = ""

    @IBOutlet weak var orderClient_id: UILabel!
    @IBOutlet weak var orderClient_full_name: UILabel!
    @IBOutlet weak var orderClient_phone: UILabel!
    @IBOutlet weak var orderOrder_status_id: UILabel!
    @IBOutlet weak var orderOrder_status_description: UILabel!
    @IBOutlet weak var orderAddress: UILabel!
    @IBOutlet weak var orderDescription: UILabel!
    
    
    override func viewDidLoad() {
        orderClient_id.text = "ID: " + String(client_id)
        orderClient_full_name.text = "Nombre Completo: " + client_full_name
        orderClient_phone.text = "Teléfono: " +  client_phone
        orderOrder_status_id.text = "Estatus: " +  String(order_status_id)
        orderOrder_status_description.text = "Estatus descr.: " +  order_status_description
        orderAddress.text = "Dirección: " +  address
        orderDescription.text = "Descripción: " +  descriptionOrders
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
