//
//  SignInViewController.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 19.09.2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    //MARK: - TextFields
    var emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите Email"
        return field
    }()
    var passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите пароль"
        field.isSecureTextEntry = true
        field.textContentType = .oneTimeCode
        return field
    }()
    
    //MARK: - Border for TextField
    var emailBorder: UIView = {
        var border = UIView()
        border.backgroundColor = .black
        return border
    }()
    var passwordBorder: UIView =  {
        var border = UIView()
        border.backgroundColor = .black
        return border
    }()
    
    //MARK: Button
    var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    
    
    //MARK: - Label
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = label.font.withSize(20)
        return label
    }()
    var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.isHidden = true
        label.numberOfLines = 0
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //MARK: - Subview
        view.addSubview(titleLabel)
        view.addSubview(errorLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(emailBorder)
        view.addSubview(passwordBorder)
        view.addSubview(enterButton)
        
        
        
        //MARK: - Constraints
        labelConstraints()
        textFieldConstrains()
        borderConstraints()
        buttonConstraints()
        
        enterButton.addTarget(self, action: #selector(enterNews), for: .touchUpInside)
    }
    
    
    func labelConstraints(){
        //MARK: - titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        //MARK: - errorLabel
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 10).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
        
    }
    
    func textFieldConstrains(){
        //MARK: - emailField
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //MARK: - passwordField
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        passwordBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
    }
    
    func borderConstraints(){
        //MARK: EmailBorder
        emailBorder.translatesAutoresizingMaskIntoConstraints = false
        emailBorder.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 1).isActive = true
        emailBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        emailBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        emailBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //MARK: - PasswordBorder
        passwordBorder.translatesAutoresizingMaskIntoConstraints = false
        passwordBorder.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 1).isActive = true
        passwordBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        passwordBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        passwordBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    func buttonConstraints(){
        //MARK: - EnterButton
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.topAnchor.constraint(equalTo: passwordBorder.bottomAnchor, constant: 30).isActive = true
        enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    
    @objc func enterNews(){
        guard let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return  }
        guard let password = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil{
                self.errorLabel.text = error?.localizedDescription
                self.errorLabel.isHidden = false
            }
        }
        errorLabel.isHidden = true
        emailField.text = nil
        passwordField.text = nil
    }
}
