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
    
    private lazy var nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите имя"
        field.becomeFirstResponder()
        return field
    }()
    private lazy var emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите Email"
        return field
    }()
    private lazy var passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите пароль"
        field.isSecureTextEntry = true
        field.textContentType = .oneTimeCode
        return field
    }()
    private lazy var nameBorder: UIView = {
        var border = UIView()
        border.backgroundColor = .black
        return border
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
    private lazy var registrButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = label.font.withSize(20)
        return label
    }()
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Error"
        label.numberOfLines = 0
        label.textColor = .red
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    private lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "У вас уже есть аккаунт?"
        label.numberOfLines = 0
        return label
    }()
    
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        //Subview
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
        //Constraints
        labelConstraints()
        textFieldConstrains()
        borderConstraints()
        buttonConstraints()
        //Button Target
        enterButton.addTarget(nil, action: #selector(goToSingIn), for: .touchUpInside)
        registrButton.addTarget(nil, action: #selector(registrNewUser), for: .touchUpInside)
        
        hideKeyboard()
    }
}

//MARK: - Target Action
extension AuthViewController {
    @objc private func registrNewUser() {
        let error = validateFields()
        if error != nil {
            showError(error ?? "Неопознанная ошибка")
        } else {
            guard  let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
            guard let email = emailField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {return}
            guard let password = passwordField.text?.trimmingCharacters(in: .whitespaces) else {return}
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error != nil {
                    self.showError("Error creating user")
                } else {
                    let db = Firestore.firestore()
                    
                    db.collection("users").document((result?.user.uid)!).setData([
                        "name": name,
                        "email": email
                    ])
                    { error in
                        if error != nil {
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
    @objc private func goToSingIn() {
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        nameField.text = nil
        emailField.text = nil
        passwordField.text = nil
        errorLabel.isHidden = true
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}


//MARK: Helper Function
extension AuthViewController {
    private func validateFields() -> String? {
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
    
    private func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    private func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}



//MARK: - Constraints UI
extension AuthViewController {
    private func labelConstraints(){
        //titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        //errorLabel
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.topAnchor.constraint(equalTo: registrButton.bottomAnchor, constant: 10).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        //accountLabel
        accountLabel.translatesAutoresizingMaskIntoConstraints = false
        accountLabel.bottomAnchor.constraint(equalTo: enterButton.topAnchor, constant: -10).isActive = true
        accountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    private func textFieldConstrains(){
        //NameField
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //EmailField
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.topAnchor.constraint(equalTo: nameBorder.bottomAnchor, constant: 20).isActive = true
        emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //PasswordField
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.topAnchor.constraint(equalTo: emailBorder.bottomAnchor, constant: 20).isActive = true
        passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    private func borderConstraints(){
        //NameBorder
        nameBorder.translatesAutoresizingMaskIntoConstraints = false
        nameBorder.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 1).isActive = true
        nameBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        nameBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        nameBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //EmailBorder
        emailBorder.translatesAutoresizingMaskIntoConstraints = false
        emailBorder.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 1).isActive = true
        emailBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        emailBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        emailBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        //PasswordBorder
        passwordBorder.translatesAutoresizingMaskIntoConstraints = false
        passwordBorder.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 1).isActive = true
        passwordBorder.heightAnchor.constraint(equalToConstant: 1).isActive = true
        passwordBorder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        passwordBorder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    private func buttonConstraints(){
        //RegistrButton
        registrButton.translatesAutoresizingMaskIntoConstraints = false
        registrButton.topAnchor.constraint(equalTo: passwordBorder.bottomAnchor, constant: 30).isActive = true
        registrButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //EnterButton
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive =  true
        enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
    
