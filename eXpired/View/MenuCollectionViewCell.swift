//
//  MenuCollectionViewCell.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    //MARK:-UI-Elements
    let menuImage = ImageView(image: "makeup")
    let menuName =  label(text: "MakeUp", textcolor: .black, font: .setFont(fontName: .Poppins_Medium, fontSize: 13), alignment: .natural)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        backgroundColor = .white
        
    }
  
    //MARK:-Helper Functions
    func setUpUI()
    {
        contentView.addSubview(menuImage)
        contentView.addSubview(menuName)
        shadowDecorate()
        clipsToBounds = false
        NSLayoutConstraint.activate([
            menuImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            menuImage.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 30.heightRatio),
            menuImage.heightAnchor.constraint(equalToConstant: 60.heightRatio),
            menuImage.widthAnchor.constraint(equalToConstant: 60.widthRatio),
            
            menuName.centerXAnchor.constraint(equalTo: centerXAnchor),
            menuName.topAnchor.constraint(equalTo: menuImage.bottomAnchor, constant: 20.heightRatio)
            
            
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
