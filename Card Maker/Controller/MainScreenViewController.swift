//
//  MainScreenViewController.swift
//  Card Maker
//
//  Created by Admin on 12/30/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    
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
    private lazy var userProfileImg: UIImageView = {
        let img = UIImage(named: "userpro5_img")
        let iv = UIImageView(image: img)
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfileButton(_ :))))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    @objc private func handleProfileButton(_ sender: UIButton) {
        let vc = UserProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        }
    private lazy var notifyImg: UIImageView = {
        let img = UIImage(named: "notify_img")
        let iv = UIImageView(image: img)
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleNotifyButton(_ :))))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    @objc private func handleNotifyButton(_ sender: UIButton) {
        let vc = UserNotifyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        }
    private lazy var continuedButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(rgb: 0xff414d)
        button.titleLabel?.textColor = .white
        button.setTitle("Continue with your cards", for: .normal)
        button.titleLabel?.font = UIFont.init(name: "LibreBaskerville-Italic", size: 20)
        button.addTarget(self, action: #selector(handleContinuedButton(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 0.5 * 30
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc private func handleContinuedButton(_ sender: UIButton) {
        let cv = ListOfUserCardViewController()
        navigationController?.pushViewController(cv, animated: true)
        
    }
    private lazy var startFromeBeginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(rgb: 0xff414d)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.init(name: "LibreBaskerville-Italic", size: 20)
        button.setTitle("Start frome the begining", for: .normal)
        button.addTarget(self, action: #selector(handleStartFromBeginButton(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 0.5 * 30
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc private func handleStartFromBeginButton(_ sender: UIButton) {
        let cv = TopicScreenViewController()
        navigationController?.pushViewController(cv, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.148111701, green: 0.1289984584, blue: 0.1116550639, alpha: 1)
        setHeaderView()
        setButtonStackView()
        setProfilenNotifyButton()
        // Do any additional setup after loading the view.
    }
    func setHeaderView() {
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
    }

    private func setButtonStackView() {
        let label = UILabel()
        label.text = "Or..."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .lightGray
        let stackView = UIStackView(arrangedSubviews: [continuedButton,label,startFromeBeginButton])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setProfilenNotifyButton() {
        view.addSubview(userProfileImg)
        NSLayoutConstraint.activate([
            userProfileImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileImg.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 8),
            userProfileImg.widthAnchor.constraint(equalToConstant: 50 ),
            userProfileImg.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        view.addSubview(notifyImg)
        NSLayoutConstraint.activate([
            notifyImg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            notifyImg.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:  -8),
            notifyImg.widthAnchor.constraint(equalToConstant: 50 ),
            notifyImg.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }

}
