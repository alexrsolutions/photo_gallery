//
//  SignUpViewController.swift
//  actividad7-2
//
//  Created by Alex Ramirez on 3/31/19.
//  Copyright © 2019 alexRsolutions. All rights reserved.
//

import UIKit
import Foundation
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirmText: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var labelWarnings: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.borderWidth = 2
        registerButton.layer.cornerRadius = registerButton.frame.height/2
        registerButton.layer.borderColor = UIColor.white.cgColor
        registerButton.contentEdgeInsets = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        
        emailText.attributedPlaceholder = NSAttributedString(string: "Email",
                                                              attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        usernameText.attributedPlaceholder = NSAttributedString(string: "Username",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        passwordText.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        confirmText.attributedPlaceholder = NSAttributedString(string: "Confirm Password",
                                                                attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)])
        
        print("SignUpPage")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerUser(_ sender: Any) {
        if ( emailText.text == "" || emailText.text == " ") {
            labelWarnings.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            labelWarnings.text = "Please enter email"
        }else if isValidEmail(email: emailText.text ?? "") == false{
            labelWarnings.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            labelWarnings.text = "Please enter a valid email"
        }else if (usernameText.text == "" || usernameText.text == " "){
            labelWarnings.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            labelWarnings.text = "Please enter username"
        }else if (passwordText.text == "" || passwordText.text == " "){
            labelWarnings.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            labelWarnings.text = "Please enter password"
        }else if (confirmText.text == "" || confirmText.text == " "){
            labelWarnings.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            labelWarnings.text = "Please confirm password"
        }else {
            if confirmText.text == passwordText.text {
                if let email = emailText.text, let password = passwordText.text{
                    
                    Auth.auth().createUser(withEmail: email, password: password, completion: { user, error in
                        
                        if let firebaseError = error{
                            print(firebaseError.localizedDescription)
                            self.labelWarnings.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                            self.labelWarnings.text = "Something went wrong please try again"
                            return
                        }
                        self.labelWarnings.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                        self.labelWarnings.text = "Registration Complete"
                        
                        let users = self.db.collection("users")
                        
                        users.document().setData(["users" : self.usernameText.text ?? ""])
                        
                    })
                    performSegue(withIdentifier: "loginSignIn", sender: nil)
                }
            }else{
                self.labelWarnings.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                self.labelWarnings.text = "Confirmation Password is wrong"
            }
        }
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "backwardsSegue", sender: self)
    }
    
    func isValidEmail(email:String) -> Bool{
        print("validate emilId: \(email)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }

}
