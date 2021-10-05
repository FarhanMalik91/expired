//
//  MakeUpViewController.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit

class ProductListController: AdsController {
   
    //MARK:-UI-Elements
   lazy var tableview : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.separatorStyle = .none
        table.backgroundColor = .clear
        table.register(CatagoriesTableViewCell.self, forCellReuseIdentifier: "CatagoriesTableViewCell")
        return table
    }()
    let plusButton = button(text: "+", color: .white, font: .setFont(fontName: .Poppins_Light, fontSize: 40), cornerradius: 30, bgcolor: Constants.AppColor.appGreen)
    let emptyLabel : label = label(text: "No Category Found", textcolor: .black, font: .setFont(fontName: .Poppins_Medium, fontSize: 22.autoSized), alignment: .center)
    var categories = [Category]()
    var categoryType : CategoriesOptions!
    var backgroundColor = UIColor()
    override func viewDidLoad(){
        super.viewDidLoad()
//        view.backgroundColor = Constants.AppColor.appBrown
        self.navigationItem.title = "Categories"
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpUI()
        plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
        getCategories()
        emptyLabel.alpha = 0
    }
    init(categoryType: CategoriesOptions , color: UIColor) {
        self.categoryType = categoryType

        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = color
        backgroundColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-Helper Function
    func setUpUI(){
        view.addSubview(tableview)
        view.addSubview(emptyLabel)
        view.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.heightRatio),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            plusButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30.heightRatio),
            plusButton.heightAnchor.constraint(equalToConstant: 60),
            plusButton.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    @objc func plusButtonPressed(){
        let controller = AddMakeUpProductController(categoryType: categoryType, color: backgroundColor)
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }

    func getCategories(){
        showLoadingView()
        ApiManager.shared.getAllCategories(categoryType) { [weak self] response in
            self?.hideLoadingView()
            
            if let response = response {
                self?.categories = response
                if response.count > 0 {
                    self?.emptyLabel.alpha = 0
                }else {
                    self?.emptyLabel.alpha = 1
                }
                self?.tableview.reloadData()
            }
        }
    }
    
}
extension ProductListController : UITableViewDelegate,UITableViewDataSource , AddMakeUpProductControllerDelegate{
    func refreshAPi() {
        getCategories()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CatagoriesTableViewCell", for: indexPath) as! CatagoriesTableViewCell
        cell.catagoryLabel.text = categories[indexPath.row].name
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82.heightRatio
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MakeUpItemController(categoryType: categoryType, color: backgroundColor)
        controller.categoryId = categories[indexPath.row].id
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
       
            let categoryId = categories[indexPath.row].id
            deleteCategory(categoryId: categoryId, index: indexPath.row)
        }
    }
    
    
    
    func deleteCategory(categoryId: String , index: Int) {
        showAlertWithDobuleButton("Attention", "Are you sure you want to delete this category?") { [weak self] in
            ApiManager.shared.deleteCategory(self!.categoryType, categoryId)
            self?.categories.remove(at: index)
            self?.tableview.reloadData()
        }
    }
}
