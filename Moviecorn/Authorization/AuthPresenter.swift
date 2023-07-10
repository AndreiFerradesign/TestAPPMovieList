//
//  AuthPresenter.swift
//  Moviecorn
//
//  Created by Andrei Kashin on 02.07.2023.
//

import Foundation

protocol AuthViewControllerProtocol: AnyObject {
    
    var isCorrectLogin: Bool { get set }
    var isCorrectPassword: Bool { get set }
    
    func success()
    func error(message: String)
}

protocol AuthPresenterProtocol: AnyObject {
    
    init(view: AuthViewControllerProtocol, router: RouterAuthProtocol, completionAuth: @escaping () -> Void)
    
    func checkValidation(username: String, password: String)
    func userLogIn()
}

final class AuthPresenter: AuthPresenterProtocol {
    
    // MARK: - Properties
    
    weak var view: AuthViewControllerProtocol?
    var router: RouterAuthProtocol?
    
    var completionAuth: () -> Void
    
    private let emptyUserNameMessage = "Пустое поле логина"
    private let emptyPasswordMessage = "Пустое поле пароля"
    private let incorrectUserNameMessage = "Неверное имя пользователя"
    private let incorrectPasswordMessage = "Неверный пароль"
    
    // MARK: - Init
    
    required init (
        view: AuthViewControllerProtocol,
        router: RouterAuthProtocol,
        completionAuth: @escaping () -> Void
    ) {
        self.view = view
        self.router = router
        self.completionAuth = completionAuth
    }
    
    // MARK: - Methods
    
    func checkValidation(username: String, password: String) {
        guard username != ""  else {
            view?.isCorrectLogin = false
            view?.error(message: emptyUserNameMessage)
            return
        }
        guard password != "" else {
            view?.isCorrectPassword = false
            view?.error(message: emptyPasswordMessage)
            return
        }
        guard username == usernameKey else {
            view?.isCorrectLogin = false
            view?.error(message: incorrectUserNameMessage)
            return
        }
        guard password == passwordKey else {
            view?.isCorrectPassword = false
            view?.error(message: incorrectPasswordMessage)
            return
        }
        view?.success()
    }
    
    func userLogIn() {
        completionAuth()
    }
    
}
