//
//  AddProductViewController.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit

class AddProductViewController: UIViewController {
    
    //MARK:-UI-Elements
    let Productlabel = label(text: "+ Add your own Product!", textcolor: #colorLiteral(red: 0.5607843137, green: 0.5607843137, blue: 0.5607843137, alpha: 1), font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .center)
    var containerView : UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    
    let productIconImage = ImageView(image: "add")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.AppColor.bgColor
        self.navigationItem.title = "Add Product"
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        productIconImage.contentMode = .scaleAspectFit
        setUpUI()
        let tap = UITapGestureRecognizer(target: self, action: #selector(addTapGesture))
        self.containerView.addGestureRecognizer(tap)
        containerView.isUserInteractionEnabled = true
    }
    override func viewDidLayoutSubviews() {
        containerView.addLineDashedStroke(pattern: [2, 2], radius: 16, color: UIColor.gray.cgColor)
    }
    //MARK:-Helper Functions
    func setUpUI()
    {
        
        view.addSubview(containerView)
       
        containerView.addSubview(Productlabel)
        Productlabel.backgroundColor = .white
       
        
        NSLayoutConstraint.activate([
        
           
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 57.widthRatio),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -57.widthRatio),
            containerView.heightAnchor.constraint(equalToConstant: 116.heightRatio),
        
            Productlabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            Productlabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            

        ])
        
    }
    @objc func addTapGesture(){
        print("Tapped here ")
        let controller = AddProductDetailViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    

   
}
