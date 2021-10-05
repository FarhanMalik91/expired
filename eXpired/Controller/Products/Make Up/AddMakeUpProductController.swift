//
//  AddCatagoryViewController.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit

protocol AddMakeUpProductControllerDelegate : AnyObject {
    func refreshAPi()
}

class AddMakeUpProductController: AdsController {
    
    //MARK:-UI-Elements
    let catagoreyTextField = txtField(text: "Enter your category", textColor:  .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 12))
    let doneButton = button(text: "Done", color: .white, font: .setFont(fontName: .Poppins_Regular, fontSize: 18), cornerradius: 5, bgcolor: Constants.AppColor.appGreen)

    var categoryType : CategoriesOptions!
    weak var delegate : AddMakeUpProductControllerDelegate? = nil
    var backgroundColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = Constants.AppColor.appBrown
        self.navigationItem.title = "Add Category"
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        catagoreyTextField.layer.cornerRadius = 0
        catagoreyTextField.layer.borderColor = UIColor.black.cgColor
        catagoreyTextField.layer.borderWidth = 1
        catagoreyTextField.backgroundColor = .clear
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        setUpUI()
    }
    
    init(categoryType: CategoriesOptions , color: UIColor) {
        self.categoryType = categoryType
        super.init(nibName: nil, bundle: nil)
        backgroundColor = color
        view.backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-Helper Functions
    func setUpUI(){
        
        view.addSubview(catagoreyTextField)
        view.addSubview(doneButton)
       
      
        NSLayoutConstraint.activate([
            
            catagoreyTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 54.heightRatio),
            catagoreyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60.widthRatio),
            catagoreyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60.widthRatio),
            catagoreyTextField.heightAnchor.constraint(equalToConstant: 40.heightRatio),
            
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -61.heightRatio),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 62.widthRatio),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62.widthRatio),
            doneButton.heightAnchor.constraint(equalToConstant: 44.heightRatio),
 
        ])
        
    }
    @objc func doneButtonPressed(){
        if catagoreyTextField.text == "" {
            showAlertWithSingleButton("Alert", "Enter Category Name") {
                return
            }
        }
            showLoadingView()
        ApiManager.shared.createCategory(categoryType, catagoreyTextField.text!)
            hideLoadingView()
        if let delegate = delegate {
            delegate.refreshAPi()
        }
            showAlertWithSingleButton("Success", "Category Added Successfuly") { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
    }

}
