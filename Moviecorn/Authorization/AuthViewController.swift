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
    
    private var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.text = "Ошибка ввода"
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 16)
        errorLabel.textAlignment = .center
        return errorLabel
    }()
    
    private var usernameTextField: UITextField = {
        let usernameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        usernameTextField.layer.cornerRadius = 8.0
        usernameTextField.layer.masksToBounds = true
        usernameTextField.autocorrectionType = UITextAutocorrectionType.no
        usernameTextField.keyboardType = UIKeyboardType.default
        usernameTextField.font = UIFont.systemFont(ofSize: 15)
        usernameTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        usernameTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return usernameTextField
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
        errorLabel.isHidden = true
        
        initAuthViewController()

    }
    
    // MARK: - Layout methods
    
    func clearTextField (textField: UITextField) {
        textField.text = ""
    }
    
    private func initAuthViewController() {
        
        view.backgroundColor = .background
        
        authLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authLabel)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorLabel)
        
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usernameTextField)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        
        NSLayoutConstraint.activate([
            authLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            authLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            authLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            authLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            errorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            errorLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            errorLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 125),
            errorLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            usernameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            usernameTextField.topAnchor.constraint(equalTo: authLabel.bottomAnchor, constant: 150),
            usernameTextField.widthAnchor.constraint(equalToConstant: 300),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            button.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 70),
            button.widthAnchor.constraint(equalToConstant: 300),
            button.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func didTapLoginButton(_ sender: UIButton) {
        
        var usernameText: String = usernameTextField.text ?? ""
        var passwordText: String = passwordTextField.text ?? ""
        
        if  passwordText == password && usernameText == username {
            
            guard let window = UIApplication.shared.windows.first else {
                assertionFailure("Invalid Configuration")
                return
            }
            let movieTableViewController = MovieTableViewController()
            window.rootViewController = movieTableViewController
            UserDefaults.standard.set(true, forKey: "LOGGED_IN")
        } else {
                    let alert = UIAlertController(
                        title: "Что то не так!",
                        message: "Попробуйте еще раз",
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(
                        title: "OK",
                        style: .default))
                    self.present(alert, animated: true)
            clearTextField(textField: usernameTextField)
            clearTextField(textField: passwordTextField)
        }
    }
}

