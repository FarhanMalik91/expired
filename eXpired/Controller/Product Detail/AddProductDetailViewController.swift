//
//  AddProductDetailViewController.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit

class AddProductDetailViewController: UIViewController {
    
    //MARK:-UI-Elements
    let productImage = ImageView(image: "make")
    let BrandNameLabel = label(text: "Brand", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let shadeLabel = label(text: "Shade", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let datePurchaseLabel = label(text: "Date Purchase", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let dateOpenedLabel = label(text: "Date Opened", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let expireyDateLabel = label(text: "Expiry Date", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let MonthLabel = label(text: "Month", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let brandNameTF = txtField(text: "Enter Name", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14))
    let shadeTF = txtField(text: "Enter Shade", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14))
    let datePurchaseTF = txtField(text: "202-555-0132", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14))
    let dateOpenedTF = txtField(text: "202-555-0132", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14))
    let expireyDateTF = txtField(text: "202-555-0132", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14))
    let monthTF = txtField(text: "202-555-0132", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14))
    let doneButton = button(text: "Done", color: .white, font: .setFont(fontName: .Poppins_Regular, fontSize: 18), cornerradius: 10, bgcolor: #colorLiteral(red: 0.137254902, green: 0.3019607843, blue: 0.4196078431, alpha: 1))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.AppColor.bgColor
        self.navigationItem.title = "Add Category"
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        productImage.contentMode = .scaleAspectFill
        productImage.layer.cornerRadius = 50
        setUPUI()
    }
    
    //MARK:-Helper Functions
    func setUPUI(){
        view.addSubview(productImage)
        
        view.addSubview(BrandNameLabel)
        view.addSubview(brandNameTF)
        
        view.addSubview(shadeLabel)
        view.addSubview(shadeTF)
        
        view.addSubview(datePurchaseLabel)
        view.addSubview(datePurchaseTF)
        
        view.addSubview(dateOpenedLabel)
        view.addSubview(dateOpenedTF)
        
        view.addSubview(expireyDateLabel)
        view.addSubview(expireyDateTF)
        
        view.addSubview(MonthLabel)
        view.addSubview(monthTF)
        
        view.addSubview(doneButton)

        NSLayoutConstraint.activate([
            productImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.heightRatio),
            productImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 138.widthRatio),
            productImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -138.widthRatio),
            productImage.heightAnchor.constraint(equalToConstant: 100),
            productImage.widthAnchor.constraint(equalToConstant: 100),
            
            BrandNameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 25.heightRatio),
            BrandNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            
            brandNameTF.topAnchor.constraint(equalTo: BrandNameLabel.bottomAnchor, constant: 5.heightRatio),
            brandNameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            brandNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            brandNameTF.heightAnchor.constraint(equalToConstant: 40.heightRatio),
            
            shadeLabel.topAnchor.constraint(equalTo: brandNameTF.bottomAnchor, constant: 5.heightRatio),
            shadeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            
            shadeTF.topAnchor.constraint(equalTo: shadeLabel.bottomAnchor, constant: 5.heightRatio),
            shadeTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            shadeTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            shadeTF.heightAnchor.constraint(equalToConstant: 40.heightRatio),
            
            datePurchaseLabel.topAnchor.constraint(equalTo: shadeTF.bottomAnchor, constant: 5.heightRatio),
            datePurchaseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            
            datePurchaseTF.topAnchor.constraint(equalTo: datePurchaseLabel.bottomAnchor, constant: 5.heightRatio),
            datePurchaseTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            datePurchaseTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            datePurchaseTF.heightAnchor.constraint(equalToConstant: 40.heightRatio),
            
            dateOpenedLabel.topAnchor.constraint(equalTo: datePurchaseTF.bottomAnchor, constant: 5.heightRatio),
            dateOpenedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            
            dateOpenedTF.topAnchor.constraint(equalTo: dateOpenedLabel.bottomAnchor, constant: 5.heightRatio),
            dateOpenedTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            dateOpenedTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            dateOpenedTF.heightAnchor.constraint(equalToConstant: 40.heightRatio),
            
            expireyDateLabel.topAnchor.constraint(equalTo: dateOpenedTF.bottomAnchor, constant: 5.heightRatio),
            expireyDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            
            expireyDateTF.topAnchor.constraint(equalTo: expireyDateLabel.bottomAnchor, constant: 5.heightRatio),
            expireyDateTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            expireyDateTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            expireyDateTF.heightAnchor.constraint(equalToConstant: 40.heightRatio),
            
            MonthLabel.topAnchor.constraint(equalTo: expireyDateTF.bottomAnchor, constant: 5.heightRatio),
            MonthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            
            monthTF.topAnchor.constraint(equalTo: MonthLabel.bottomAnchor, constant: 5.heightRatio),
            monthTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            monthTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            monthTF.heightAnchor.constraint(equalToConstant: 40.heightRatio),
            
            doneButton.topAnchor.constraint(equalTo: monthTF.bottomAnchor, constant: 50.heightRatio),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            doneButton.heightAnchor.constraint(equalToConstant: 44.heightRatio),
   
        ])
        
    }
    

   

}
