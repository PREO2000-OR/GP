//
//  Dashboard.swift
//  GP
//
//  Created by Oswaldo Osuna on 22/04/21.
//

import UIKit

class Dashboard: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func didTapButton(){
        guard let vc = storyboard?.instantiateViewController(identifier: "mainMenu_vc") as? MainMenu else {
            return
        }
        present(vc, animated: true)
    }
}
