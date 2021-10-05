//
//  SettingsViewController.swift
//  eXpired
//
//  Created by Sarmad Ishfaq on 11/08/2021.
//

import UIKit
import FirebaseAuth

class SettingsViewController: AdsController {

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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Settings"
        view.backgroundColor = Constants.AppColor.bgColor
        setupViews()
    
    }

    func setupViews(){
        view.addSubview(tableview)

        
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.heightRatio),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

        ])
        
    }

}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "CatagoriesTableViewCell", for: indexPath) as! CatagoriesTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.catagoryLabel.text = "Change Password"
        case 1:
            cell.catagoryLabel.text = "Change Notification Setting"
        case 2:
            cell.catagoryLabel.text = "Delete Account"
        case 3:
            cell.catagoryLabel.text = "Log Out"
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82.heightRatio
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
           let conroller = ChangePasswordController()
            navigationController?.pushViewController(conroller, animated: true)
        case 1:
            showSettings()
        case 2:
           deleteUser()
        case 3:
            logOut()
        default:
            break
        }
    }
    
    func deleteUser() {
        showAlertWithDobuleButton("Attention", "Are you sure you want to Delete Account?") { [weak self] in
            self?.showLoadingView()
            DataManager.shared.removeUserData()
            NotificationManager.shared.destroyeAllNotifications()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                self?.hideLoadingView()
                Auth.auth().currentUser?.delete(completion: { error in
                    if let error = error {
                        self?.showAlertWithSingleButton("Alert", error.localizedDescription) {
                            
                        }
                    }else {
                        let controller = LoginController()
                        controller.modalPresentationStyle = .overFullScreen
                        self?.present(controller, animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    func logOut(){
        showAlertWithDobuleButton("Attention", "Are you sure you want to Log Out?") { [weak self] in
            self?.showLoadingView()
            DataManager.shared.removeUserData()
            NotificationManager.shared.destroyeAllNotifications()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                
                do {
                    try Auth.auth().signOut()
                    self?.hideLoadingView()
                    let controller = LoginController()
                    controller.modalPresentationStyle = .overFullScreen
                    self?.present(controller, animated: true, completion: nil)
                }catch {
                    print("problem with logout")
                }
            }
        }
    }
    
    func showSettings() {
        if let aString = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(aString, options: [:], completionHandler: { success in
              
                    })
                }
    }
}
