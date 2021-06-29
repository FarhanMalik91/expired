//
//  MakeUpViewController.swift
//  eXpired
//
//  Created by Malik Farhan Asim on 28/06/2021.
//

import UIKit

class ProductListController: UIViewController {
   
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

    override func viewDidLoad(){
        super.viewDidLoad()
        view.backgroundColor = Constants.AppColor.bgColor
        self.navigationItem.title = "Categories"
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpUI()
        plusButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
    }
    //MARK:-Helper Function
    func setUpUI(){
        view.addSubview(tableview)
        view.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
            
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
    @objc func plusButtonPressed()
    {
        let controller = AddMakeUpProductController()
        navigationController?.pushViewController(controller, animated: true)
    }

}
extension ProductListController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CatagoriesTableViewCell", for: indexPath) as! CatagoriesTableViewCell
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82.heightRatio
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = MakeUpItemController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    
    
}
