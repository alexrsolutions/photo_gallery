//
//  InitialViewController.swift
//  actividad7-2
//
//  Created by Alex Ramirez on 4/13/19.
//  Copyright © 2019 alexRsolutions. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var loginSegue: UIButton!
    @IBOutlet weak var registerSegue: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginSegue.layer.borderWidth = 2
        loginSegue.layer.cornerRadius = loginSegue.frame.height/2
        loginSegue.layer.borderColor = UIColor.white.cgColor
        loginSegue.contentEdgeInsets = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        
        registerSegue.layer.borderWidth = 2
        registerSegue.layer.cornerRadius = registerSegue.frame.height/2
        registerSegue.layer.borderColor = UIColor.white.cgColor
        registerSegue.contentEdgeInsets = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
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
