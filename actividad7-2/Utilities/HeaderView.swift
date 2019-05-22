//
//  HeaderView.swift
//  actividad7-2
//
//  Created by Alex Ramirez on 4/13/19.
//  Copyright © 2019 alexRsolutions. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView{
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    var categoryTitle: String!{
        didSet{
            categoryTitleLabel.text = categoryTitle
        }
    }
    
}
