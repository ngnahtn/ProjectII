//
//  UserProfileViewController.swift
//  Card Maker
//
//  Created by Admin on 11/12/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import Firebase

class UserProfileViewController: UIViewController {
    weak var navigation: UINavigationController?
    
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor(rgb: 0xff414d), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleBackButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(rgb: 0xff414d)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleLogoutButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var userProfileStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var headerView : UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
        return vw
    }()
    
    lazy var nameLable : UILabel = {
        var lable = UILabel()
        lable.backgroundColor = .clear
        lable.text = "Name"
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    lazy var emailLable : UILabel = {
        var lable = UILabel()
        lable.backgroundColor = .clear
        lable.text = "Email Address"
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private lazy var nameField : UITextField = {
        let tf = UITextField()
        tf.textColor = .black
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
        tf.isEnabled = false
        tf.textColor = .black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    override func viewDidLoad() {
        getUserInfor()
        super.viewDidLoad()
        view.backgroundColor = .white
        setTheView()
        setProfileStackView()
        setButtonStackView()
        
    }
    
    fileprivate func getUserInfor() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("user").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if let directionary = snapshot.value as? [String: AnyObject] {
                self.nameField.text = directionary["name"] as? String
                self.emailField.text = directionary["email"] as? String
            }
        }, withCancel: nil)
    }

    
    func setTheView() {
        
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4)
        ])
    }
    
    func setProfileStackView() {
        view.addSubview(userProfileStackView)
        NSLayoutConstraint.activate([
            userProfileStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: 12),
            userProfileStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -12),
            userProfileStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            userProfileStackView.heightAnchor.constraint(equalToConstant: 120)
        ])
        
        let stack1 = UIStackView(arrangedSubviews: [nameLable,emailLable])
        let stack2 = UIStackView(arrangedSubviews: [nameField,emailField])
        
        stack1.axis = .vertical
        stack1.alignment = .fill
        stack1.distribution = .fillEqually
        
        
        stack2.axis = .vertical
        stack2.alignment = .fill
        stack2.distribution = .fillEqually
        
        
        self.userProfileStackView.addArrangedSubview(stack1)
        self.userProfileStackView.addArrangedSubview(stack2)
        }
    
    func setButtonStackView() {
        
        let buttonStackView = UIStackView(arrangedSubviews: [backButton,logoutButton])
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.backgroundColor = .clear
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 12),
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func handleBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleLogoutButton(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let vc = LoginView()
        self.navigationController?.pushViewController(vc, animated: true)
    }/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
