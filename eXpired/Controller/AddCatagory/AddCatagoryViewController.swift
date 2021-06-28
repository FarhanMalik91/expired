//
//  AddCatagoryViewController.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit

class AddCatagoryViewController: UIViewController {
    
    //MARK:-UI-Elements
    let catagoreyTextField = txtField(text: "Enter your catagory", textColor:  #colorLiteral(red: 0.5607843137, green: 0.5607843137, blue: 0.5607843137, alpha: 1), font: .setFont(fontName: .Poppins_Regular, fontSize: 12))
    let doneButton = button(text: "Done", color: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 18), cornerradius: 5, bgcolor: #colorLiteral(red: 0.137254902, green: 0.3019607843, blue: 0.4196078431, alpha: 1))
    let categorylabel = label(text: "+ Add your own Category", textcolor: #colorLiteral(red: 0.5607843137, green: 0.5607843137, blue: 0.5607843137, alpha: 1), font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .center)
    var containerView : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .clear
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.AppColor.bgColor
        self.navigationItem.title = "Add Category"
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        catagoreyTextField.layer.cornerRadius = 0
        catagoreyTextField.layer.borderColor = #colorLiteral(red: 0.8078431373, green: 0.7803921569, blue: 0.7803921569, alpha: 1)
        catagoreyTextField.layer.borderWidth = 1
        catagoreyTextField.backgroundColor = .clear
        setUpUI()
    }
    override func viewDidLayoutSubviews() {
        containerView.addLineDashedStroke(pattern: [2, 2], radius: 16, color: UIColor.gray.cgColor)
    }
    //MARK:-Helper Functions
    func setUpUI(){
        
        view.addSubview(containerView)
        containerView.addSubview(categorylabel)
        view.addSubview(catagoreyTextField)
        view.addSubview(doneButton)
       
      
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 54.heightRatio),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57.widthRatio),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -57.widthRatio),
            containerView.heightAnchor.constraint(equalToConstant: 116.heightRatio),
            
            categorylabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            categorylabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            
            catagoreyTextField.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 52.heightRatio),
            catagoreyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60.widthRatio),
            catagoreyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60.widthRatio),
            catagoreyTextField.heightAnchor.constraint(equalToConstant: 40.heightRatio),
            
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -61.heightRatio),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 62.widthRatio),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62.widthRatio),
            doneButton.heightAnchor.constraint(equalToConstant: 44.heightRatio),
 
        ])
        
    }

  

}
