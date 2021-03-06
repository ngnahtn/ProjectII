//
//  UserListTableViewController.swift
//  Card Maker
//
//  Created by Admin on 12/2/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import Firebase

class UserListTableViewController: UITableViewController {
    var users = [User]()
    var textFontString = ""
    var text = ""
    var textSize : CGFloat?
    var textPosition : CGRect?
    var textColor : String?
    var audioStringName = ""
    var selectedImage = UIImageView()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false,animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Friends List"
        tableView.backgroundColor = .white
        tableView.register(UserCell.self, forCellReuseIdentifier: "cellID")
        fetchUser()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Back To Home", style: .plain, target: self, action: #selector(addTapped))
    }
    @objc func addTapped() {
        let cv = MainScreenViewController()
        self.navigationController?.pushViewController(cv, animated: true)
    
    }
    private func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("user").observe(.childAdded) { [weak self] (snapshot) in
            guard let `self` = self else {return}
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User()
                user.userID = snapshot.key
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                if uid != user.userID {
                self.users.append(user)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                
                }
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! UserCell
        let user  = users[indexPath.row]
//        cell.textLabel?.text = user.name
//        cell.textLabel?.font = cell.textLabel?.font.withSize(20)
//        cell.detailTextLabel?.text = user.email
//        cell.detailTextLabel?.font = cell.detailTextLabel?.font.withSize(14)
//        cell.backgroundColor = .white
//        cell.textLabel?.textColor = .black
//        cell.detailTextLabel?.textColor = .black
        cell.user = user
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        Database.database()
        let cv = MessageViewController()
        let user = users[indexPath.row]
        cv.user = user
        cv.text = self.text
        cv.textPosition = self.textPosition!
        cv.audioStringName = self.audioStringName
        cv.selectedImage = self.selectedImage
        cv.textColor = self.textColor
        cv.textSize = textSize
        cv.textFontString = self.textFontString
        self.navigationController?.pushViewController(cv, animated: true)
    }
}



    
