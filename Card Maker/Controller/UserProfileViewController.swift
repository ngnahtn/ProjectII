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
    var cardDictionary = [String: Card]()
    var cards = [Card]()
    var cellID = "cellID"
    var users = [User]()
    private lazy var messageTableView: UITableView = {
       var tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    private lazy var messageLable: UILabel = {
        var lable = UILabel()
        lable.backgroundColor = .clear
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.text = "Message"
        lable.textColor = .black
        lable.font = UIFont.boldSystemFont(ofSize: 24)
        return lable
    }()
    private lazy var profileSeparatorView : UIView = {
        let vieww = UIView()
        vieww.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        vieww.translatesAutoresizingMaskIntoConstraints = false
        return vieww
    }()
    private lazy var buttonSeparatorView: UIView = {
        let vieww = UIView()
        vieww.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        vieww.translatesAutoresizingMaskIntoConstraints = false
        return vieww
    }()
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
        lable.textColor = .black
        lable.backgroundColor = .clear
        lable.text = "Name"
        lable.font = UIFont.boldSystemFont(ofSize: 20)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    lazy var emailLable : UILabel = {
        var lable = UILabel()
        lable.textColor = .black
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
        messageTableView.register(UserCell.self, forCellReuseIdentifier: cellID)
        setProfileStackView()
        setButtonStackView()
        setTableView()
        observeUserMessages()
        
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
            userProfileStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        
        view.addSubview(profileSeparatorView)
        NSLayoutConstraint.activate([
            profileSeparatorView.topAnchor.constraint(equalTo: userProfileStackView.bottomAnchor, constant: 0),
            profileSeparatorView.leadingAnchor.constraint(equalTo: userProfileStackView.leadingAnchor),
            profileSeparatorView.widthAnchor.constraint(equalTo: userProfileStackView.widthAnchor),
            profileSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
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
        view.addSubview(buttonSeparatorView)
        NSLayoutConstraint.activate([
            buttonSeparatorView.topAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),
            buttonSeparatorView.leadingAnchor.constraint(equalTo: buttonStackView.leadingAnchor),
            buttonSeparatorView.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor),
            buttonSeparatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
    }
    private func setTableView() {
        let stackView = UIStackView(arrangedSubviews: [messageLable,messageTableView])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 10
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: profileSeparatorView.bottomAnchor,constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -12),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 12),
            stackView.bottomAnchor.constraint(equalTo: buttonSeparatorView.topAnchor,constant: -10)
        ])
    }
    private func observeUserMessages() {
        guard let userID = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("userMessages").child(userID)
        ref.observe(.childAdded, with: { (snapshot) in
            let uID = snapshot.key
            Database.database().reference().child("userMessages").child(userID).child(uID).observe(.childAdded, with: {[weak self] (snapshot) in
                guard let `self` = self else {return}
                let messageID = snapshot.key
                let messagesRef = Database.database().reference().child("SelectedCard").child(messageID)
                messagesRef.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
                    guard let `self` = self else {return}
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let card = Card()

                        card.userID = dictionary["userID"] as? String
                        card.toUserID = dictionary["toUserID"] as? String
                        card.audioNameString = dictionary["audioName"] as? String
                        card.imageURL = dictionary["cardImageURL"] as? String
        //                self.cards.append(card)
                        self.reloadTable(card: card)
                        
                    }
                }, withCancel: nil)
            }, withCancel: nil)
        }, withCancel: nil)
    }
    private func reloadTable(card: Card) {
        if let chatPartnerID = card.chatPartnerID() {
            self.cardDictionary[chatPartnerID] = card
            self.cards = Array(self.cardDictionary.values)
        }
        
        DispatchQueue.main.async {
            self.messageTableView.reloadData()
        }
    }
//    private func observeCard() {
//        let ref = Database.database().reference().child("SelectedCard")
//        ref.observe(.childAdded, with: { [weak self] (snapshot) in
//            guard let `self` = self else {return}
//            if let dictionary = snapshot.value as? [String: AnyObject] {
//                let card = Card()
//
//                card.userID = dictionary["userID"] as? String
//                card.toUserID = dictionary["toUserID"] as? String
//                card.audioNameString = dictionary["audioName"] as? String
//                card.imageURL = dictionary["cardImageURL"] as? String
////                self.cards.append(card)
//
//                if let toID = card.toUserID {
//                    self.cardDictionary[toID] = card
//                    self.cards = Array(self.cardDictionary.values)
//                }
//
//                DispatchQueue.main.async {
//                    self.messageTableView.reloadData()
//                }
//            }
//        }, withCancel: nil)
//    }
    
    
    @objc func handleBackButton(_ sender: UIButton) {
        print(cards)
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
    }
}

extension UserProfileViewController: UITableViewDelegate {
    
}

extension UserProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! UserCell
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        let card = cards[indexPath.row]
        let chatPartnerID : String?
        if card.userID == Auth.auth().currentUser?.uid {
            chatPartnerID = card.toUserID
        } else {
            chatPartnerID = card.userID
        }
        if let id = chatPartnerID {
            let ref = Database.database().reference().child("user").child(id)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary  = snapshot.value as? [String: AnyObject] {
//                    cell.textLabel?.text = dictionary["email"] as? String
//                    guard let userName = dictionary["name"] as? String else {return}
                    let user = User()
                    user.email = dictionary["email"] as? String
                    user.name = dictionary["name"] as? String
                    cell.user = user
                }
            }, withCancel: nil)
        }
        cell.selectionStyle = .none
        return cell
    }
    private func setCell(cell: UITableViewCell, user: User) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cards[indexPath.row]
        guard let chatPartnerID = card.chatPartnerID() else {return}

        let ref = Database.database().reference().child("user").child(chatPartnerID)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            let user = User()
            user.userID = chatPartnerID
            user.email = dictionary["email"] as? String
            user.name = dictionary["name"] as? String
            let cv = MessageViewController()
            cv.user = user
            self.navigationController?.pushViewController(cv, animated: true)
        }, withCancel: nil)
    }
    
}
