//
//  UserNotifyViewController.swift
//  Card Maker
//
//  Created by Admin on 12/26/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UserNotifyViewController: UITableViewController {
    var notifies = [Notify]()
    var users = [User]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        tableView.register(NotifyCell.self, forCellReuseIdentifier: "cellID")
        observeNotification()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func observeNotification() {
        guard  let userID = Auth.auth().currentUser?.uid else {
            return
        }
        Database.database().reference().child("user-notify").child(userID).observe(.childAdded, with: { [weak self](snapshot) in
            guard let `self` = self else {return}
            guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
            let notify = Notify()
            notify.fromID = dictionary["fromID"] as? String
            notify.timestamp = dictionary["timestamp"] as? NSNumber
            guard let fromUserID = notify.fromID else {return}
            
            Database.database().reference().child("user").child(fromUserID).observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
                guard let `self` = self else {return}
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let user = User()
                    user.email = dictionary["email"] as? String
                    user.name = dictionary["name"] as? String
                    user.userID = fromUserID
                    self.users.append(user)
                    self.notifies.append(notify)
                    self.notifies.sort { (notify1, notify2) -> Bool in
                        return notify1.timestamp!.intValue > notify2.timestamp!.intValue
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }, withCancel: nil)
            
//            self.notifies.append(notify)

            
            
            
        }, withCancel: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! NotifyCell
        let user = users[indexPath.row]
        let notify = notifies[indexPath.row]
        cell.notify = notify
        cell.user = user
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
