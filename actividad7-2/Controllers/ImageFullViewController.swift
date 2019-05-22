//
//  ImageFullViewController.swift
//  actividad7-2
//
//  Created by Alex Ramirez on 4/11/19.
//  Copyright © 2019 alexRsolutions. All rights reserved.
//

import UIKit

class ImageFullViewController: UIViewController {

    @IBOutlet weak var imageDetails: UIImageView!
    
    var image = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageString = image
        let url = URL(string: imageString)
        let data = NSData(contentsOf: url!)
        imageDetails.image = UIImage(data: data! as Data)
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
