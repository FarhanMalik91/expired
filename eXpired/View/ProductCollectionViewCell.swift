//
//  ProductCollectionViewCell.swift
//  eXpired
//
//  Created by Sarmad Ishfaq on 03/08/2021.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    //MARK:-UI-Elements
    let menuImage = ImageView(image: "makeup")
    let menuName =  label(text: "MakeUp", textcolor: .black, font: .setFont(fontName: .Poppins_Medium, fontSize: 13), alignment: .center)
    let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        backgroundColor = .white
        menuImage.layer.cornerRadius = 12.autoSized
        menuName.numberOfLines = 2
    }
  
    //MARK:-Helper Functions
    func setUpUI(){
        addSubview(containerView)
        containerView.addSubview(menuImage)
        containerView.addSubview(menuName)
        shadowDecorate()
        clipsToBounds = false
        NSLayoutConstraint.activate([
            
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            

            menuImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            menuImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            menuImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            menuImage.heightAnchor.constraint(equalToConstant: 60.autoSized),
            menuImage.widthAnchor.constraint(equalToConstant: 60.autoSized),
            
            
            menuName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.autoSized),
            menuName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.autoSized),
            menuName.topAnchor.constraint(equalTo: menuImage.bottomAnchor, constant: 10.heightRatio),
            menuName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCellWithTitlteAndImage(index : Int){
        switch index {
        case 0:
            menuName.text = "Make Up"
            menuImage.image = UIImage(named: "makeup")
            
        case 1:
            menuName.text = "Skin Care"
            menuImage.image = UIImage(named: "skincare")
            
        case 2:
            menuName.text = "Perfume /\n Aftershave"
            menuImage.image = UIImage(named: "perfume")
            
        case 3:
            menuName.text = "Setting"
            menuImage.image = UIImage(named: "settings")

        default:
            break
        }
    }
}
