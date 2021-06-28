//
//  Label.swift
//  DeliciousFood
//
//  Created by Malik Farhan Asim on 01/04/2021.
//

import Foundation
import UIKit


class label : UILabel
{
    init(text : String , textcolor : UIColor , font  : UIFont , alignment : NSTextAlignment ) {
        super.init(frame: CGRect.zero)
        self.text = text
        self.textColor = textcolor
        self.font = UIFont(name: (font.fontName), size: CGFloat(Int(font.pointSize).widthRatio))
        self.textAlignment = alignment
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
