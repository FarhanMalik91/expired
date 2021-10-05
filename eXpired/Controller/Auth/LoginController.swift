//
//  LoginController.swift
//  eXpired
//
//  Created by Sarmad Ishfaq on 01/08/2021.
//

import UIKit
import FirebaseAuth


class LoginController: UIViewController {
    
    let logoImage : ImageView = ImageView(image: "logo")
    let welcomeText : label = label(text: "Welcome", textcolor: .black, font: .setFont(fontName: .Poppins_Medium, fontSize: 30.autoSized), alignment: .left)
    let loginDetailText : label = label(text: "Please sign in to continue", textcolor: #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1), font: .setFont(fontName: .Poppins_Light, fontSize: 17.autoSized), alignment: .left)
    let emailFeild = txtField(text: "Email", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 17.autoSized))
    let passwordFeild = txtField(text: "Password", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 17.autoSized))
    let forgotButton = button(text: "Forgot Password?", color: .black, font: .setFont(fontName: .Poppins_Medium, fontSize: 15.autoSized), cornerradius: 0, bgcolor: .clear)
    let signupButton = button(text: "Don’t have an account?", color: .black, font: .setFont(fontName: .Poppins_Medium, fontSize: 15.autoSized), cornerradius: 0, bgcolor: .clear)
    let bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9098039216, blue: 0.9137254902, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let loginButton : UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "right-arrow"), for: .normal)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        logoImage.layer.cornerRadius = 10.autoSized
        loginButton.layer.cornerRadius = 16.autoSized
        emailFeild.keyboardType = .emailAddress
        passwordFeild.isSecureTextEntry = true
        navigationController?.navigationBar.isHidden = true
        signupButton.addTarget(self, action: #selector(singupButtonPressed), for: .touchUpInside)
        forgotButton.addTarget(self, action: #selector(forgotPasswordPressed), for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func setupViews(){
        view.addSubview(logoImage)
        view.addSubview(welcomeText)
        view.addSubview(loginDetailText)
        view.addSubview(emailFeild)
        view.addSubview(passwordFeild)
        view.addSubview(forgotButton)
        view.addSubview(signupButton)
        view.addSubview(bottomView)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            
            logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 97.autoSized),
            logoImage.widthAnchor.constraint(equalToConstant: 100.autoSized),
            logoImage.heightAnchor.constraint(equalToConstant: 100.autoSized),
            
            
            welcomeText.leadingAnchor.constraint(equalTo: logoImage.leadingAnchor),
            welcomeText.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 46.autoSized),
            
            loginDetailText.leadingAnchor.constraint(equalTo: logoImage.leadingAnchor),
            loginDetailText.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 2.autoSized),
            
            emailFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 25.widthRatio),
            emailFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -25.widthRatio),
            emailFeild.topAnchor.constraint(equalTo: loginDetailText.bottomAnchor , constant: 25.autoSized),
            emailFeild.heightAnchor.constraint(equalToConstant: 45.autoSized),
            
            passwordFeild.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 25.widthRatio),
            passwordFeild.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -25.widthRatio),
            passwordFeild.topAnchor.constraint(equalTo: emailFeild.bottomAnchor , constant: 16.autoSized),
            passwordFeild.heightAnchor.constraint(equalToConstant: 45.autoSized),
            
            forgotButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
            forgotButton.topAnchor.constraint(equalTo: passwordFeild.bottomAnchor, constant: 25.autoSized),
            
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
    
    @objc func singupButtonPressed(){
        let controller = SignupController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    @objc func loginButtonPressed(){
        
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
        
        showLoadingView()
        ApiManager.shared.signIn(emailFeild.text!, passwordFeild.text!) { [weak self] user, error in
            self?.hideLoadingView()
            if let _ = user {
                let controller = UINavigationController(rootViewController: DashboardController())
                controller.modalPresentationStyle = .overFullScreen
                self?.present(controller, animated: true, completion: nil)
            }
            
            if let error = error {
                self?.showAlertWithSingleButton("Alert", error, completion: {
                    
                })
            }
            
        }
        
    }
    
    
    @objc func forgotPasswordPressed(){
        showInputDialog(title: "Enter Email Address",
                        subtitle: "Please enter the email address for you account.",
                        actionTitle: "Rest",
                        cancelTitle: "Cancel",
                        inputPlaceholder: "Enter Email Address",
                        inputKeyboardType: .emailAddress, actionHandler:
                            { [weak self] (input:String?) in
                                self?.showLoadingView()
                                Auth.auth().sendPasswordReset(withEmail: input ?? "") { [weak self] error in
                                    if let error = error {
                                        self?.hideLoadingView()
                                        self?.showAlertWithSingleButton("Alert!", error.localizedDescription) {
                                            
                                        }
                                    }else {
                                        self?.hideLoadingView()
                                        self?.showAlertWithSingleButton("Attention", "Password reset link has been sent to your entered email address") {
                                            
                                        }
                                    }
                                }
                            })
    }
}
