//
//  ViewController.swift
//  actividad7-2
//
//  Created by Alex Ramirez on 3/7/19.
//  Copyright © 2019 alexRsolutions. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var labelWarnings: UILabel!
    var userIdDelegate: user?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailInput.attributedPlaceholder = NSAttributedString(string: "Email",
                                                              attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        passwordInput.attributedPlaceholder = NSAttributedString(string: "Password",
                                                              attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        signInButton.layer.borderWidth = 2
        signInButton.layer.cornerRadius = signInButton.frame.height/2
        signInButton.layer.borderColor = UIColor.white.cgColor
        signInButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailInput.text!, password: passwordInput.text!) { (users, error) in
            if users != nil{
                self.performSegue(withIdentifier: "login", sender: self)
                self.labelWarnings.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                self.labelWarnings.text = "Login Succesful"
            }else{
                self.labelWarnings.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                self.labelWarnings.text = "Not connected or wrong email or password"
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "bacwardsSegueLog", sender: self)
    }
    
    
}

