//
//  Buttons.swift
//  DeliciousFood
//
//  Created by Malik Farhan Asim on 02/04/2021.
//

import Foundation
import UIKit

class button: UIButton {
    init(text : String , color : UIColor , font : UIFont , cornerradius : Int , bgcolor : UIColor) {
        super.init(frame: CGRect.zero)
        self.setTitle(text, for: .normal)
        self.setTitle(text, for: .highlighted)
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(color, for: .highlighted)
        self.backgroundColor = bgcolor
        self.titleLabel?.font = font
        self.layer.cornerRadius = CGFloat(cornerradius.autoSized)
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
