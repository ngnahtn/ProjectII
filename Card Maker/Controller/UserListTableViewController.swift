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
    var audioStringName = ""
    var selectedImage = UIImageView()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false,animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "User List"
        tableView.register(UserCell.self, forCellReuseIdentifier: "cellID")
        fetchUser()
    }
    private func fetchUser() {
        Database.database().reference().child("user").observe(.childAdded) { [weak self] (snapshot) in
            guard let `self` = self else {return}
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let user = User()
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                self.users.append(user)
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
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        let toUserEmail = users[indexPath.row].email
        let toUser = users[indexPath.row].name
        let imageUUID = UUID().uuidString
        let audioName = audioStringName
        let imgRef = Storage.storage().reference(withPath: "/CardSelected/\(imageUUID).jpg")
        guard let imgData = selectedImage.image?.jpegData(compressionQuality: 0.75) else { return }
        let updateMetaData = StorageMetadata.init()
        updateMetaData.contentType = " image/jpeg"

        imgRef.putData(imgData, metadata: updateMetaData) { (downloadMetadata, error) in
            if let error = error {
                print(error)
            } else {
                imgRef.downloadURL { (url, Error) in
                    let value = ["userID": userID, "toUserEmail" : toUserEmail, "toUserName": toUser, "audioName": audioName, "cardImageURL": url?.absoluteString] as [String: AnyObject]
                    createSelectedCardDatabase(value: value)

                }
                print("bo may load xong roi")
            }
        }
//        Database.database()
        let cv = MessageViewController()
        navigationController?.pushViewController(cv, animated: true)
    }
}
private func createSelectedCardDatabase(value: [String: AnyObject]) {
    let cardID = UUID().uuidString
    let ref = Database.database().reference(fromURL:"https://cardmakeroffice.firebaseio.com/")
    let userRef = ref.child("SelectedCard").child(cardID)
//    let value = ["name": name, "email": email]
    userRef.updateChildValues(value) { (err, ref) in
        if err != nil {
        print(err!)
        return
        }
        print("Update CardDatabase Successfully")
    }
}

class UserCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
