//
//  CurrentOrders.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

class CurrentOrders: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var myArray = [
            [
                "a": "1",
                "b": "2",
                "c": "3",
            ],
            [
                "a": "4",
                "b": "5",
                "c": "6",
            ]
        ]
    
    
    @IBAction func didTapButtonOrders(){
        guard let vc = storyboard?.instantiateViewController(identifier: "mainMenu_vc") as? MainMenu else {
            return
        }
        present(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        cell.textLabel!.text = "\(myArray[indexPath.row]["a"] )"
        cell.label.text = "3"
            return cell
    }
    
    
    @IBOutlet private var Orders: UITableView!
    override func viewDidLoad() {
        print(myArray)
        
        
        super.viewDidLoad()
        
        
            let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
            let displayWidth: CGFloat = self.view.frame.width
            let displayHeight: CGFloat = self.view.frame.height
        Orders = UITableView(frame: CGRect(x: 0, y: 100, width: displayWidth, height: displayHeight - barHeight))
        Orders.register(Cell.self, forCellReuseIdentifier: "Cell")
        Orders.dataSource = self
        Orders.delegate = self
        self.view.addSubview(Orders)
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

class Cell: UITableViewCell {
   
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
