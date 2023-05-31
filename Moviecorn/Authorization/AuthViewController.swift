//
//  AuthViewController.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 30.05.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: - Layout elements
    
    private var authLabel: UILabel = {
        let authLabel = UILabel()
        authLabel.text = "Авторизация"
        authLabel.textColor = .white
        authLabel.font = UIFont.systemFont(ofSize: 28)
        authLabel.textAlignment = .center
        return authLabel
    }()
    
    private var loginTextField: UITextField = {
        let loginTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        loginTextField.placeholder = "Login"
        loginTextField.borderStyle = UITextField.BorderStyle.roundedRect
        loginTextField.layer.cornerRadius = 8.0
        loginTextField.layer.masksToBounds = true
        loginTextField.autocorrectionType = UITextAutocorrectionType.no
        loginTextField.keyboardType = UIKeyboardType.default
        loginTextField.font = UIFont.systemFont(ofSize: 15)
        loginTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        loginTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return loginTextField
    }()
    
    private var passwordTextField: UITextField = {
        let passwordTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.layer.cornerRadius = 8.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return passwordTextField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.setTitleColor(.background, for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAuthViewController()
    }
    
    // MARK: - Layout methods
    
    private func initAuthViewController() {
        
        view.backgroundColor = .background
        
        authLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authLabel)
        
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        
        NSLayoutConstraint.activate([
            authLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            authLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            authLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            authLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loginTextField.topAnchor.constraint(equalTo: authLabel.bottomAnchor, constant: 150),
            loginTextField.widthAnchor.constraint(equalToConstant: 300),
            loginTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 30),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            button.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 70),
            button.widthAnchor.constraint(equalToConstant: 300),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func didTapLoginButton(_ sender: UIButton) {
        
        print("Hello")
        
        let alert = UIAlertController(
            title: "Что то не так!",
            message: "Попробуйте еще раз",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(
            title: "Да",
            style: .default,
            handler: { [weak self] _ in
                guard let self = self else { return }
                //                 self.logOut()
                self.present(alert, animated: true)
            }))
        alert.addAction(UIAlertAction(
            title: "Нет",
            style: .default))
        self.present(alert, animated: true)
    }
}
