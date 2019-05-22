//
//  ButtonLayout.swift
//  actividad7-2
//
//  Created by Alex Ramirez on 4/13/19.
//  Copyright © 2019 alexRsolutions. All rights reserved.
//

import UIKit

class ButtonLayout: UIButton {
    
    override func awakeFromNib() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = frame.height/2
    }

}
