//
//  AuthViewController.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 30.05.2023.
//

import UIKit

final class AuthViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: AuthPresenterProtocol?
    internal var isCorrectLogin: Bool = true
    internal var isCorrectPassword: Bool = true
    
    // MARK: - Layout elements
    
    private var authLabel: UILabel = {
        let authLabel = UILabel()
        authLabel.text = "Авторизация"
        authLabel.textColor = .white
        authLabel.font = UIFont.systemFont(ofSize: 28)
        authLabel.textAlignment = .center
        authLabel.translatesAutoresizingMaskIntoConstraints = false
        return authLabel
    }()
    
    private var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.text = "Ошибка ввода"
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 18)
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
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
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        return usernameTextField
    }()
    
    private var passwordTextField: UITextField = {
        let passwordTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
        passwordTextField.placeholder = "Password"
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.layer.cornerRadius = 8.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.font = UIFont.systemFont(ofSize: 15)
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        return passwordTextField
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.setTitleColor(.background, for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldDelegate()
        initAuthViewController()
        
    }
    
    // MARK: - Layout methods
    
    
    private func initAuthViewController() {
        
        view.backgroundColor = .background
        
        view.addSubview(authLabel)
        view.addSubview(errorLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
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
            button.heightAnchor.constraint(equalToConstant: 40)
            
        ])
    }
    
    // MARK: - Actions
    
    @objc private func didTapLoginButton(_ sender: UIButton) {
        presenter?.checkValidation(
            username: usernameTextField.text ?? String(),
            password: passwordTextField.text ?? String()
        )
    }
}

// MARK: - AuthViewControllerProtocol

extension AuthViewController: AuthViewControllerProtocol {
    
    func success() {
        presenter?.userLogIn()
    }
    
    func error(message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(2)) { [self] in
            errorLabel.isHidden = true
        }
    }
}

// MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    
    private func textFieldDelegate() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case usernameTextField:
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            textField.resignFirstResponder()
            presenter?.checkValidation(
                username: usernameTextField.text ?? String(),
                password: passwordTextField.text ?? String()
            )
        default:
            break
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
}


