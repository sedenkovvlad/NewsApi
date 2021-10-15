//
//  SignInViewController.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 19.09.2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    private lazy var emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите Email"
        field.becomeFirstResponder()
        return field
    }()
    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите пароль"
        field.isSecureTextEntry = true
        field.textContentType = .oneTimeCode
        return field
    }()
    private lazy var emailBorder: UIView = {
        var border = UIView()
        border.backgroundColor = .black
        return border
    }()
    private lazy var passwordBorder: UIView =  {
        var border = UIView()
        border.backgroundColor = .black
        return border
    }()
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = label.font.withSize(20)
        return label
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.isHidden = true
        label.numberOfLines = 0
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //SubView
        view.addSubview(titleLabel)
        view.addSubview(errorLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(emailBorder)
        view.addSubview(passwordBorder)
        view.addSubview(enterButton)
        //Constraints
        labelConstraints()
        textFieldConstrains()
        borderConstraints()
        buttonConstraints()
        //function
        enterButton.addTarget(self, action: #selector(enterNews), for: .touchUpInside)
        hideKeyboard()
    }
}

//MARK: Helper Functions
extension SignInViewController {
    
    @objc private func enterNews() {
        guard let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if error != nil{
                self?.errorLabel.text = error?.localizedDescription
                self?.errorLabel.isHidden = false
            }
        }
        errorLabel.isHidden = true
        emailField.text = nil
        passwordField.text = nil
    }
    
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}

//MARK: Constraints UI
extension SignInViewController {
    private func labelConstraints() {
        //titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        //errorLabel
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 10).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        
    }
    private func textFieldConstrains() {
        //emailField
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //passwordField
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        passwordBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    private func borderConstraints() {
        //emailBorder
        emailBorder.translatesAutoresizingMaskIntoConstraints = false
        emailBorder.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 1).isActive = true
        emailBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        emailBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        emailBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //passwordBorder
        passwordBorder.translatesAutoresizingMaskIntoConstraints = false
        passwordBorder.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 1).isActive = true
        passwordBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        passwordBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        passwordBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    private func buttonConstraints() {
        //enterButton
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.topAnchor.constraint(equalTo: passwordBorder.bottomAnchor, constant: 30).isActive = true
        enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}


