//
//  ViewControllerSelect.swift
//  actividad7-2
//
//  Created by Alex Ramirez on 3/28/19.
//  Copyright © 2019 alexRsolutions. All rights reserved.
//

import UIKit

class ViewControllerSelect: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInSection(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: self)
    }
    
}
