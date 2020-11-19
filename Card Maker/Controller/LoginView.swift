//
//  LoginView.swift
//  Card Maker
//
//  Created by Admin on 11/11/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import Firebase

class LoginView: UIViewController {
    
    var textViewHeighConstraint: NSLayoutConstraint?
    var nametextFieldHeighConstraint: NSLayoutConstraint?
    var nameSeparatorViewHeigh: NSLayoutConstraint?
    var emailTextFieldHeighConstraint: NSLayoutConstraint?
    var passwordTextFieldHeighConstraint: NSLayoutConstraint?
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = #colorLiteral(red: 0.148111701, green: 0.1289984584, blue: 0.1116550639, alpha: 1)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var textView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Username",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)])
        tf.textColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private lazy var nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var emailField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "exams@gmail.com",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)])
        tf.textColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    private lazy var emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private lazy var passwordField : UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Password",
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.5)])
        tf.textColor = .white
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
//    private lazy var passwordSeparatorView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()

    private lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor(rgb: 0xff414d)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLoginRegisterButton(_:)), for: .touchUpInside)
        return button
        
    }()
    
    private lazy var loginRegisterSegment : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Login", "Register"])
//        sc.backgroundColor = UIColor(rgb: 0xff414d)
        sc.selectedSegmentTintColor = UIColor(rgb: 0xff414d)
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            sc.setTitleTextAttributes(titleTextAttributes, for: .normal)
            sc.setTitleTextAttributes(titleTextAttributes, for: .selected)
//        sc.tintColor = UIColor(rgb: 0xff414d)
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleLoginRegisterSegment), for: .valueChanged)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
        
    }()
    
   @objc func handleLoginRegisterSegment() {
    let title = loginRegisterSegment.titleForSegment(at: loginRegisterSegment.selectedSegmentIndex)
    loginRegisterButton.setTitle(title, for: .normal)
    
    
    textViewHeighConstraint?.isActive = false
    textViewHeighConstraint = textView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier:loginRegisterSegment.selectedSegmentIndex == 0 ? 1/3 : 1/2)
    textViewHeighConstraint?.isActive = true
    
    nametextFieldHeighConstraint?.isActive = false
    nametextFieldHeighConstraint = nameField.heightAnchor.constraint(equalTo: textView.heightAnchor, multiplier:loginRegisterSegment.selectedSegmentIndex == 0 ? 0 : 1/3)
    nametextFieldHeighConstraint?.isActive = true
    
    nameSeparatorViewHeigh?.constant = loginRegisterSegment.selectedSegmentIndex == 0 ? 0 : 1
    
    emailTextFieldHeighConstraint?.isActive = false
    emailTextFieldHeighConstraint = emailField.heightAnchor.constraint(equalTo: textView.heightAnchor, multiplier: loginRegisterSegment.selectedSegmentIndex == 0 ? 1/2: 1/3)
    emailTextFieldHeighConstraint?.isActive = true
    
    passwordTextFieldHeighConstraint?.isActive = false
    passwordTextFieldHeighConstraint = passwordField.heightAnchor.constraint(equalTo: textView.heightAnchor, multiplier: loginRegisterSegment.selectedSegmentIndex == 0 ? 1/2: 1/3)
    passwordTextFieldHeighConstraint?.isActive = true

    
//    textViewHeighConstraint
    }
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont(name: "Piazzolla-ThinItalic", size: 24)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleTouchButton(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private lazy var appName : UILabel = {
        let lable = UILabel()
        lable.text = "Card Maker"
        lable.textColor = UIColor(rgb: 0xff414d)
        lable.font = UIFont.init(name: "LacostaPERSONALUSEONLY", size: 40)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textAlignment = .center
        return lable
        
    }()
    
    private lazy var welcomeImg: UIImageView = {
        let img = UIImage(named: "welcome_img")
        let imgView = UIImageView(image: img)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.148111701, green: 0.1289984584, blue: 0.1116550639, alpha: 1)
        view.addSubview(textView)
        
        setheaderContraint()
        setTextFieldConstraint()
        setButtonConstraint()
        setSegment()
        // Do any additional setup after loading the view.
    }
    
    func setheaderContraint() {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4)
        ])
        
        headerView.backgroundColor = .clear
        headerView.addSubview(appName)
        headerView.addSubview(welcomeImg)

        NSLayoutConstraint.activate([
            welcomeImg.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            welcomeImg.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            welcomeImg.topAnchor.constraint(equalTo: headerView.topAnchor),
            welcomeImg.heightAnchor.constraint(equalTo: headerView.heightAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            appName.topAnchor.constraint(equalTo: headerView.topAnchor),
            appName.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            appName.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            appName.rightAnchor.constraint(equalTo: headerView.rightAnchor)
        ])
        
        
//        textViewHeighConstraint = textView.heightAnchor.constraint(equalToConstant: 150)
        textViewHeighConstraint = textView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2)
//        self.textHeighConstraint?.priority = .required - 1
        textViewHeighConstraint?.isActive = true
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24)
        ])
        
        
        
    }
    
    func setTextFieldConstraint() {
        
        textView.addSubview(nameField)
        textView.addSubview(nameSeparatorView)
        textView.addSubview(emailField)
        textView.addSubview(emailSeparatorView)
        textView.addSubview(passwordField)
//        textView.addSubview(passwordSeparatorView)
        
        nametextFieldHeighConstraint = nameField.heightAnchor.constraint(equalTo: textView.heightAnchor, multiplier: 1/3)
        nametextFieldHeighConstraint?.isActive = true
        
        nameSeparatorViewHeigh = nameSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        nameSeparatorViewHeigh?.isActive = true

        emailTextFieldHeighConstraint = emailField.heightAnchor.constraint(equalTo: textView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeighConstraint?.isActive = true
        
        passwordTextFieldHeighConstraint = passwordField.heightAnchor.constraint(equalTo: textView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeighConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: textView.topAnchor),
            nameField.leftAnchor.constraint(equalTo: textView.leftAnchor,constant: 12),
            nameField.widthAnchor.constraint(equalTo: textView.widthAnchor),
            nameSeparatorView.topAnchor.constraint(equalTo: nameField.bottomAnchor),
            nameSeparatorView.leftAnchor.constraint(equalTo: textView.leftAnchor),
            nameSeparatorView.widthAnchor.constraint(equalTo: textView.widthAnchor),
                        
            emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor),
            emailField.leftAnchor.constraint(equalTo: textView.leftAnchor,constant: 12),
            
            emailField.widthAnchor.constraint(equalTo: textView.widthAnchor),
            emailSeparatorView.topAnchor.constraint(equalTo: emailField.bottomAnchor),
            emailSeparatorView.leftAnchor.constraint(equalTo: textView.leftAnchor),
            emailSeparatorView.widthAnchor.constraint(equalTo: textView.widthAnchor),
            emailSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor),
            passwordField.leftAnchor.constraint(equalTo: textView.leftAnchor,constant: 12),
            
            passwordField.widthAnchor.constraint(equalTo: textView.widthAnchor),
        ])
    }
    
    func setButtonConstraint() {
        
        view.addSubview(loginRegisterButton)
        NSLayoutConstraint.activate([
            loginRegisterButton.topAnchor.constraint(equalTo: textView.bottomAnchor,constant: 12),
            loginRegisterButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            loginRegisterButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
//            loginRegisterButton.widthAnchor.constraint(equalTo:textView.widthAnchor),
            loginRegisterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(skipButton)
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
            skipButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            skipButton.widthAnchor.constraint(equalToConstant: 100),
            skipButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setSegment() {
        view.addSubview(loginRegisterSegment)
        
        NSLayoutConstraint.activate([
            loginRegisterSegment.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginRegisterSegment.bottomAnchor.constraint(equalTo: textView.topAnchor,constant: -12),
            loginRegisterSegment.widthAnchor.constraint(equalTo: textView.widthAnchor),
            loginRegisterSegment.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func handleTouchButton(_ sender: UIButton) {
        let topicScreen = TopicScreenViewController()
        self.navigationController?.pushViewController(topicScreen, animated: true)
    }
    
    @objc private func handleLoginRegisterButton(_ sender: UIButton) {
        if loginRegisterSegment.selectedSegmentIndex == 0 {
            handleLoginButton()
        } else {
            handleRegisterButtonn()
        }
    }
    
    @objc private func handleLoginButton() {
        guard let email = emailField.text, let password = passwordField.text  else {
            return
        }
//        let ref = Database.database().reference(fromURL:"https://cardmakeroffice.firebaseio.com/").child("user").child("")
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
            } else {
            let vc = TopicScreenViewController()
            self.navigationController?.pushViewController(vc, animated: true)
               
            }
        }
    }
    
    @objc private func handleRegisterButtonn() {
        guard let name = self.nameField.text, let email = emailField.text, let password = passwordField.text  else {
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error!)
                return
            }
            
            let ref = Database.database().reference(fromURL:"https://cardmakeroffice.firebaseio.com/")
            let userRef = ref.child("user").child(result!.user.uid)
            let value = ["name": name, "email": email]
            userRef.updateChildValues(value) { (err, ref) in
                if err != nil {
                print(err!)
                return
                }
                print("Successfully")
                let vc = TopicScreenViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
