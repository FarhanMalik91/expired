//
//  SignupController.swift
//  eXpired
//
//  Created by Sarmad Ishfaq on 01/08/2021.
//

import UIKit

class SignupController: UIViewController {
    
    let logoImage : ImageView = ImageView(image: "logo")
    let welcomeText : label = label(text: "Hi,", textcolor: .black, font: .setFont(fontName: .Poppins_Medium, fontSize: 30.autoSized), alignment: .left)
    let loginDetailText : label = label(text: "Enter your information below", textcolor: #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1), font: .setFont(fontName: .Poppins_Light, fontSize: 17.autoSized), alignment: .left)
    let nameFeild = txtField(text: "Name", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 17.autoSized))
    let emailFeild = txtField(text: "Email", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 17.autoSized))
    let passwordFeild = txtField(text: "Password", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 17.autoSized))
    let cPasswordFeild = txtField(text: "Confirm Password", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 17.autoSized))

    let signupButton = button(text: "Already have an account?", color: .black, font: .setFont(fontName: .Poppins_Medium, fontSize: 15.autoSized), cornerradius: 0, bgcolor: .clear)
    let bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9098039216, blue: 0.9137254902, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let loginButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow"), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.3490196078, blue: 0.3568627451, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        emailFeild.keyboardType = .emailAddress
        passwordFeild.isSecureTextEntry = true
        cPasswordFeild.isSecureTextEntry = true
        setupViews()
        logoImage.layer.cornerRadius = 10.autoSized
        loginButton.layer.cornerRadius = 16.autoSized
        navigationController?.navigationBar.isHidden = true
        signupButton.addTarget(self, action: #selector(alreadyHaveAnyAccountButtonPressed), for: .touchUpInside)
    }
    
    func setupViews(){
        view.addSubview(logoImage)
        view.addSubview(welcomeText)
        view.addSubview(loginDetailText)
        view.addSubview(emailFeild)
        view.addSubview(passwordFeild)
        view.addSubview(nameFeild)
        view.addSubview(cPasswordFeild)
        view.addSubview(signupButton)
        view.addSubview(bottomView)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
        
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70.autoSized),
            logoImage.widthAnchor.constraint(equalToConstant: 100.autoSized),
            logoImage.heightAnchor.constraint(equalToConstant: 100.autoSized),
            
            
            welcomeText.leadingAnchor.constraint(equalTo: logoImage.leadingAnchor),
            welcomeText.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 46.autoSized),
            
            loginDetailText.leadingAnchor.constraint(equalTo: logoImage.leadingAnchor),
            loginDetailText.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 2.autoSized),
            
            
            nameFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 25.widthRatio),
            nameFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -25.widthRatio),
            nameFeild.topAnchor.constraint(equalTo: loginDetailText.bottomAnchor , constant: 25.autoSized),
            nameFeild.heightAnchor.constraint(equalToConstant: 45.autoSized),
            
            emailFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 25.widthRatio),
            emailFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -25.widthRatio),
            emailFeild.topAnchor.constraint(equalTo: nameFeild.bottomAnchor , constant: 16.autoSized),
            emailFeild.heightAnchor.constraint(equalToConstant: 45.autoSized),
            
            passwordFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 25.widthRatio),
            passwordFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -25.widthRatio),
            passwordFeild.topAnchor.constraint(equalTo: emailFeild.bottomAnchor , constant: 16.autoSized),
            passwordFeild.heightAnchor.constraint(equalToConstant: 45.autoSized),
        
            cPasswordFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 25.widthRatio),
            cPasswordFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -25.widthRatio),
            cPasswordFeild.topAnchor.constraint(equalTo: passwordFeild.bottomAnchor , constant: 16.autoSized),
            cPasswordFeild.heightAnchor.constraint(equalToConstant: 45.autoSized),

            
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -38.autoSized),
            loginButton.widthAnchor.constraint(equalToConstant: 60.widthRatio),
            loginButton.heightAnchor.constraint(equalToConstant: 60.autoSized),
            
            
            signupButton.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 25.widthRatio),
            signupButton.bottomAnchor.constraint(equalTo: bottomView.topAnchor , constant: -5.autoSized),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 66.autoSized),
            
        ])
        
    }
    
    @objc func alreadyHaveAnyAccountButtonPressed(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func signupButtonPressed(){
        guard nameFeild.text != "" else {
            showAlertWithSingleButton("Alert", "Please Enter Name") {
                
            }
            return
        }
        
        guard emailFeild.text != "" else {
            showAlertWithSingleButton("Alert", "Please Enter Email Address") {
                
            }
            return
        }
        guard passwordFeild.text != "" else {
            showAlertWithSingleButton("Alert", "Please Enter Password") {
                
            }
            return
        }
        guard passwordFeild.text == cPasswordFeild.text else {
            showAlertWithSingleButton("Alert", "Password didn't match") {
                
            }
            return
        }
        
        showLoadingView()
        ApiManager.shared.createUser(emailFeild.text!, passwordFeild.text!, nameFeild.text!) { [weak self] message, error in
            self?.hideLoadingView()
            if let message = message {
                self?.showAlertWithSingleButton("Success", message, completion: { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                    
                })
            }
            if let error = error {
                self?.showAlertWithSingleButton("Alert", error, completion: {
                })
            }
        }
    }
}
