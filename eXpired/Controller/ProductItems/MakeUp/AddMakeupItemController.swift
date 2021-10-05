//
//  AddProductDetailViewController.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit

protocol AddMakeupItemControllerDelegate: AnyObject {
    func refreshApi()
}

class AddMakeupItemController: UIViewController {
    
    //MARK:-UI-Elements
    let productImage = ImageView(image: "makeup")
    let BrandNameLabel = label(text: "Brand", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let shadeLabel = label(text: "Shade", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let datePurchaseLabel = label(text: "Date Purchased", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let dateOpenedLabel = label(text: "Date Opened", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let expireyDateLabel = label(text: "Expiry Date", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let MonthLabel = label(text: "Months", textcolor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), alignment: .natural)
    let brandNameTF = txtField(text: "Enter Name", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14) , textAlignment: .center)
    let shadeTF = txtField(text: "Enter Shade", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), textAlignment: .center)
    let datePurchaseTF = txtField(text: "Select date purchased", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14) , textAlignment: .center)
    let dateOpenedTF = txtField(text: "Select date opened", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), textAlignment: .center)
    let expireyDateTF = txtField(text: "Select date expiry", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), textAlignment: .center)
    let monthTF = txtField(text: "Enter duration", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 14), textAlignment: .center)
    let doneButton = button(text: "Done", color: .white, font: .setFont(fontName: .Poppins_Regular, fontSize: 18), cornerradius: 10, bgcolor: Constants.AppColor.appGreen)
    lazy var addImageButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addImage")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(addImageButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.tintColor = Constants.AppColor.appGreen
        return button
    }()
    var categoryId: String = ""
    var categoryType : CategoriesOptions!
    weak var delegate: AddMakeupItemControllerDelegate? = nil
    var products : Product? = nil
    var backgroundColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = Constants.AppColor.bgColor
        self.navigationItem.title = "Add Product"
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        productImage.contentMode = .scaleAspectFill
        productImage.layer.cornerRadius = 50.widthRatio
        productImage.layer.borderWidth = 1
        productImage.layer.borderColor = Constants.AppColor.appGreen.cgColor
        
        setUPUI()
        datePurchaseTF.addInputViewDatePicker(target: self, selector: #selector(datePurchaseButtonPressed))
        dateOpenedTF.addInputViewDatePicker(target: self, selector: #selector(dateOpenedButtonPressed))
        expireyDateTF.addInputViewDatePicker(target: self, selector: #selector(dateExpireButtonPressed))

        monthTF.keyboardType = .numberPad
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        
    }
    
    init(categoryType: CategoriesOptions , color: UIColor) {
        self.categoryType = categoryType
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = color
        backgroundColor = color
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateFeilds()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-Helper Functions
    func setUPUI(){
        
        view.addSubview(productImage)
        view.addSubview(addImageButton)
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
            productImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productImage.widthAnchor.constraint(equalToConstant: 100.widthRatio),
            productImage.heightAnchor.constraint(equalTo: productImage.widthAnchor),
            
            addImageButton.widthAnchor.constraint(equalToConstant: 25),
            addImageButton.heightAnchor.constraint(equalToConstant: 25),
            
            addImageButton.trailingAnchor.constraint(equalTo: productImage.trailingAnchor),
            addImageButton.bottomAnchor.constraint(equalTo: productImage.bottomAnchor),
            
            BrandNameLabel.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 15.heightRatio),
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
            
            expireyDateLabel.topAnchor.constraint(equalTo: monthTF.bottomAnchor, constant: 5.heightRatio),
            expireyDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            
            expireyDateTF.topAnchor.constraint(equalTo: expireyDateLabel.bottomAnchor, constant: 5.heightRatio),
            expireyDateTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            expireyDateTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            expireyDateTF.heightAnchor.constraint(equalToConstant: 40.heightRatio),
            
            MonthLabel.topAnchor.constraint(equalTo: dateOpenedTF.bottomAnchor, constant: 5.heightRatio),
            MonthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            
            monthTF.topAnchor.constraint(equalTo: MonthLabel.bottomAnchor, constant: 5.heightRatio),
            monthTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            monthTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            monthTF.heightAnchor.constraint(equalToConstant: 40.heightRatio),
            
            doneButton.topAnchor.constraint(equalTo: expireyDateTF.bottomAnchor, constant: 25.heightRatio),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            doneButton.heightAnchor.constraint(equalToConstant: 44.heightRatio),
   
        ])
        
      
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        productImage.layer.cornerRadius = productImage.frame.height / 2
    }
   
    func populateFeilds(){
        guard products != nil else { return }
        productImage.downloadImage(url: products!.imageUrl)
        brandNameTF.text = products?.brand
        shadeTF.text = products?.shade
        datePurchaseTF.text = products?.datePurchase
        dateOpenedTF.text = products?.dateOpened
        monthTF.text = products?.month
        expireyDateTF.text = products?.dateExpiry
        doneButton.setTitle("Update", for: .normal)
    }
    
    //MARK:-Selectors
    @objc func datePurchaseButtonPressed() {
        if let  datePicker = self.datePurchaseTF.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.datePurchaseTF.text = dateFormatter.string(from: datePicker.date)
        }
        self.datePurchaseTF.resignFirstResponder()
     }
    @objc func dateOpenedButtonPressed() {
        if let  datePicker = self.dateOpenedTF.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.dateOpenedTF.text = dateFormatter.string(from: datePicker.date)
        }
        self.dateOpenedTF.resignFirstResponder()
     }
    @objc func dateExpireButtonPressed() {
        if let  datePicker = self.expireyDateTF.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.expireyDateTF.text = dateFormatter.string(from: datePicker.date)
        }
        self.expireyDateTF.resignFirstResponder()
     }
    @objc func monthbuttonPressed() {
        if let  datePicker = self.monthTF.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.dateFormat = "MMMM"
            self.monthTF.text = dateFormatter.string(from: datePicker.date)
        }
        self.monthTF.resignFirstResponder()
     }
    @objc func addImageButtonPressed(){
        ImagePickerManager().pickImage(self) { [weak self] (image) in
            DispatchQueue.main.async { [weak self] in
                self?.productImage.image = image
            }
        }
    }
    
    
    @objc func doneButtonPressed(){
        if brandNameTF.text == "" {
            showAlertWithSingleButton("Alert", "Please Enter Brand Name") {
                
            }
            return
        }
        if shadeTF.text == "" {
            showAlertWithSingleButton("Alert", "Please Enter Shade Name") {
                
            }
            return
        }
        if datePurchaseTF.text == "" {
            showAlertWithSingleButton("Alert", "Please Enter Purchase Date ") {
                
            }
            return
        }
        if dateOpenedTF.text == "" {
            showAlertWithSingleButton("Alert", "Please Enter Opened Date ") {
                
            }
            return
        }
        
        if monthTF.text == "" {
            showAlertWithSingleButton("Alert", "Please Select Month") {
                
            }
        
        
        if expireyDateTF.text == "" {
            showAlertWithSingleButton("Alert", "Please Enter Expiry Date") {
                
            }
            return
        }
            return
        }
        showLoadingView()
        
        if products == nil {
            ApiManager.shared.uploadMedia(image: productImage.image!) { [weak self] url in
                if let url = url {
                    let notificationId = UUID().uuidString
                    ApiManager.shared.addProductIntoCategory(self!.categoryType ,self!.categoryId, self!.brandNameTF.text!, self!.shadeTF.text!, self!.datePurchaseTF.text!, self!.dateOpenedTF.text!, self!.expireyDateTF.text!, self!.monthTF.text!, url , notificationId: notificationId)
                    self?.hideLoadingView()
                    if let delegate = self?.delegate {
                        delegate.refreshApi()
                    }
                    NotificationManager.shared.createNotification(brandName: self!.brandNameTF.text!, brandId: notificationId, expiryDate: self!.expireyDateTF.text!)
                    self?.showAlertWithSingleButton("Success", "Product added Successfully", completion: { [weak self] in
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
            }
        }else {
            ApiManager.shared.uploadMedia(image: productImage.image!) { [weak self] url in
                if let url = url {
                    let notificationId = UUID().uuidString
                    ApiManager.shared.updateProductIntoCategory(self!.categoryType ,self!.categoryId, self!.brandNameTF.text!, self!.shadeTF.text!, self!.datePurchaseTF.text!, self!.dateOpenedTF.text!, self!.expireyDateTF.text!, self!.monthTF.text!, url , productId: self!.products?.id ?? "", notificationId: notificationId)
                    self?.hideLoadingView()
                    if let delegate = self?.delegate {
                        delegate.refreshApi()
                    }
                    NotificationManager.shared.updateNotification(brandName: self!.brandNameTF.text!, brandId: notificationId, expiryDate: self!.expireyDateTF.text!)
                    self?.showAlertWithSingleButton("Success", "Product added Successfully", completion: { [weak self] in
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
            }
        }
        
        
    }
}
