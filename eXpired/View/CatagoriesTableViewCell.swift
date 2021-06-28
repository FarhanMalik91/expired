//
//  CatagoriesTableViewCell.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit

class CatagoriesTableViewCell: UITableViewCell {
    
    //MARK:-UI-Elements
    let catagoryLabel = label(text: "Lips", textcolor: .black, font: .setFont(fontName: .Poppins_Medium, fontSize: 16), alignment: .natural)
    let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
        selectionStyle = .none
        backgroundColor = .clear
    }

    //MARK:-Helper Functions
    func setUpUI(){
        containerView.dropShadow()
        addSubview(containerView)
        containerView.addSubview(catagoryLabel)

        NSLayoutConstraint.activate([
            
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 10.heightRatio),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.heightRatio),
            
            catagoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            catagoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 19.widthRatio),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
