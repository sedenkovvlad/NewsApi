//
//  AuthViewController.swift
//  NewsFinal
//
//  Created by Владислав Седенков on 19.09.2021.
//

import UIKit
import Firebase
import FirebaseAuth


class AuthViewController: UIViewController {

        //MARK: - TextFields
        var nameField: UITextField = {
            let field = UITextField()
            field.placeholder = "Введите имя"
            return field
        }()
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
        var nameBorder: UIView = {
            var border = UIView()
            border.backgroundColor = .black
            return border
        }()
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
        var registrButton: UIButton = {
            let button = UIButton()
            button.setTitle("Зарегистрироваться", for: .normal)
            button.setTitleColor(.orange, for: .normal)
            return button
        }()
        var enterButton: UIButton = {
            let button = UIButton()
            button.setTitle("Войти", for: .normal)
            button.setTitleColor(.orange, for: .normal)
            return button
        }()
        
        //MARK: - Label
        var titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Регистрация"
            label.font = label.font.withSize(20)
            return label
        }()
        var errorLabel: UILabel = {
            let label = UILabel()
            label.text = "Error"
            label.numberOfLines = 0
            label.textColor = .red
            label.textAlignment = .center
            label.isHidden = true
            return label
        }()
        var accountLabel: UILabel = {
            let label = UILabel()
            label.text = "У вас уже есть аккаунт?"
            label.numberOfLines = 0
            return label
        }()
   

        
        //MARK: - LifeCycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = .white
            //MARK: - Subview
            view.addSubview(titleLabel)
            view.addSubview(errorLabel)
            view.addSubview(accountLabel)
            view.addSubview(nameField)
            view.addSubview(emailField)
            view.addSubview(passwordField)
            view.addSubview(nameBorder)
            view.addSubview(emailBorder)
            view.addSubview(passwordBorder)
            view.addSubview(registrButton)
            view.addSubview(enterButton)
            //MARK: - Constraints
            labelConstraints()
            textFieldConstrains()
            borderConstraints()
            buttonConstraints()
            //MARK: - Button Target
            enterButton.addTarget(nil, action: #selector(goToSingIn), for: .touchUpInside)
            registrButton.addTarget(nil, action: #selector(registrNewUser), for: .touchUpInside)
        }
    }


    //MARK: - Constraints Objects
    extension AuthViewController{
        func labelConstraints(){
            //MARK: - titleLabel
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            //MARK: - errorLabel
            errorLabel.translatesAutoresizingMaskIntoConstraints = false
            errorLabel.topAnchor.constraint(equalTo: registrButton.bottomAnchor, constant: 10).isActive = true
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            //MARK: - accountLabel
            accountLabel.translatesAutoresizingMaskIntoConstraints = false
            accountLabel.bottomAnchor.constraint(equalTo: enterButton.topAnchor, constant: -10).isActive = true
            accountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        
        func textFieldConstrains(){
            //MARK: - NameField
            nameField.translatesAutoresizingMaskIntoConstraints = false
            nameField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            //MARK: - EmailField
            emailField.translatesAutoresizingMaskIntoConstraints = false
            emailField.topAnchor.constraint(equalTo: nameBorder.bottomAnchor, constant: 20).isActive = true
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            //MARK: - PasswordField
            passwordField.translatesAutoresizingMaskIntoConstraints = false
            passwordField.topAnchor.constraint(equalTo: emailBorder.bottomAnchor, constant: 20).isActive = true
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        }
        func borderConstraints(){
            //MARK: NameBorder
            nameBorder.translatesAutoresizingMaskIntoConstraints = false
            nameBorder.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 1).isActive = true
            nameBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
            nameBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            nameBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            //MARK: - EmailBorder
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
            //MARK: - RegistrButton
            registrButton.translatesAutoresizingMaskIntoConstraints = false
            registrButton.topAnchor.constraint(equalTo: passwordBorder.bottomAnchor, constant: 30).isActive = true
            registrButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            //MARK: = EnterButton
            enterButton.translatesAutoresizingMaskIntoConstraints = false
            enterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive =  true
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        
    }

    //MARK: - Function
    extension AuthViewController{
        //MARK: - User registration
        @objc func registrNewUser(){
            let error = validateFields()
            if error != nil{
                showError(error ?? "Неопознанная ошибка")
            }else{
                
                guard  let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
                guard let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
                guard let password = passwordField.text?.trimmingCharacters(in: .whitespaces) else {return}
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if error != nil {
                        self.showError("Error creating user")
                    }else{
                        let db = Firestore.firestore()
                        
                        db.collection("users").document((result?.user.uid)!).setData([
                            "name": name,
                            "email": email
                        ]) { error in
                            if error != nil{
                                self.showError("Error saving user data")
                            }
                        }
                        self.errorLabel.isHidden = true
                        self.nameField.text = nil
                        self.emailField.text = nil
                        self.passwordField.text = nil
                    }
                  
                }
            }
        }
       
        func validateFields() -> String? {
            if nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
                passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Пожалуйста заполните все поля."
            }
            let correctPassword = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            if Utilities.isPasswordValid(correctPassword!) == false {
                return "Убедитесь, что ваш пароль состоит не менее чем из 8 символов, содержит специальный символ и цифру."
            }
            return nil
        }
        
        
        func showError(_ message: String){
            errorLabel.text = message
            errorLabel.isHidden = false
        }
        
        @objc func goToSingIn(){
            let vc = SignInViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            nameField.text = nil
            emailField.text = nil
            passwordField.text = nil
            errorLabel.isHidden = true
        }
    }

