//
//  ChangePasswordController.swift
//  eXpired
//
//  Created by Sarmad Ishfaq on 19/08/2021.
//

import UIKit
import FirebaseAuth


class ChangePasswordController: UIViewController {
    
    let emailFeild = txtField(text: "Email", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 17.autoSized))
    let passwordFeild = txtField(text: "Current Password", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 17.autoSized))
    let confirmPasswordFeild = txtField(text: "New Password", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 17.autoSized))
    let doneButton = button(text: "Done", color: .white, font: .setFont(fontName: .Poppins_Regular, fontSize: 18), cornerradius: 10, bgcolor: Constants.AppColor.appGreen)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        navigationItem.title = "Settings"
        view.backgroundColor = Constants.AppColor.bgColor
        setupViews()
    }
    
    func setupViews(){
        view.addSubview(emailFeild)
        view.addSubview(passwordFeild)
        view.addSubview(confirmPasswordFeild)
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
        
            emailFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 25.widthRatio),
            emailFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -25.widthRatio),
            emailFeild.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 25.autoSized),
            emailFeild.heightAnchor.constraint(equalToConstant: 45.autoSized),
            
            passwordFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 25.widthRatio),
            passwordFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -25.widthRatio),
            passwordFeild.topAnchor.constraint(equalTo: emailFeild.bottomAnchor , constant: 25.autoSized),
            passwordFeild.heightAnchor.constraint(equalToConstant: 45.autoSized),
            
            confirmPasswordFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 25.widthRatio),
            confirmPasswordFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -25.widthRatio),
            confirmPasswordFeild.topAnchor.constraint(equalTo: passwordFeild.bottomAnchor , constant: 25.autoSized),
            confirmPasswordFeild.heightAnchor.constraint(equalToConstant: 45.autoSized),
            
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30.heightRatio),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.widthRatio),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.widthRatio),
            doneButton.heightAnchor.constraint(equalToConstant: 44.heightRatio),
            
        ])
    }
    
    
    @objc func doneButtonPressed(){
        guard emailFeild.text != "" else {
            showAlertWithSingleButton("Alert", "Please Enter Email Address") {
                
            }
            return
        }
        guard passwordFeild.text != "" else {
            showAlertWithSingleButton("Alert", "Please Enter Current Password") {
                
            }
            return
        }
        
        guard  confirmPasswordFeild.text != ""  else {
            showAlertWithSingleButton("Alert", "Please Enter New Password") {
                
            }
            return
        }
        
        changePassword(email: emailFeild.text!, currentPassword: passwordFeild.text!, newPassword: confirmPasswordFeild.text!)
    }
    
    
        func changePassword(email: String, currentPassword: String, newPassword: String){
            let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
            showLoadingView()
            Auth.auth().currentUser?.reauthenticate(with: credential, completion: { [weak self] result, error in
                if error == nil {
                    Auth.auth().currentUser?.updatePassword(to: newPassword, completion: { [weak self] error in
                        if error == nil {
                            self?.hideLoadingView()
                            self?.showAlertWithSingleButton("Success", "Password Change successfuly") { [weak self] in
                                self?.navigationController?.popViewController(animated: true)
                            }
                        }else {
                            self?.hideLoadingView()
                            self?.showAlertWithSingleButton("Alert!", error?.localizedDescription ?? "", completion: {
                                
                            })
                        }
                    })
                }else {
                    self?.hideLoadingView()
                    self?.showAlertWithSingleButton("Alert!", error?.localizedDescription ?? "", completion: {
                        
                    })
                }
            })
        }
}
