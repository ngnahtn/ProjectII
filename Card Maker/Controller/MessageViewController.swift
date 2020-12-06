//
//  MessageViewController.swift
//  Card Maker
//
//  Created by Admin on 12/3/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
class MessageViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var audioStringName = ""
    var cards = [Card]()
    var selectedImage : UIImageView?
    var user : User? {
        didSet {
            self.navigationItem.title = user?.name
            observeCardImage()
        }
    }
    
    private func observeCardImage() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userMessagesRef = Database.database().reference().child("userMessages").child(uid)
            userMessagesRef.observe(.childAdded, with: { [weak self] (snapshot) in
                guard let `self` = self else {return}
            let cardID = snapshot.key
            let messageRef = Database.database().reference().child("SelectedCard").child(cardID)
            messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let dictionary = snapshot.value as? [String: AnyObject] else {return}
                let card = Card()
                card.userID = dictionary["userID"] as? String
                card.toUserID = dictionary["toUserID"] as? String
                card.audioNameString = dictionary["audioName"] as? String
                card.imageURL = dictionary["cardImageURL"] as? String
                
                if card.chatPartnerID() == self.user?.userID {
                    self.cards.append(card)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
                
                
            }, withCancel: nil)
        }, withCancel: nil)
    }
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleSendButton(_ :)), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    @objc private func handleSendButton(_ sender: UIButton) {
        guard let userID = Auth.auth().currentUser?.uid else {
            return
        }
        guard let toID = user?.userID else {return}
        let imageUUID = UUID().uuidString
        let audioName = audioStringName
        let imgRef = Storage.storage().reference(withPath: "/CardSelected/\(imageUUID).jpg")
        guard let imgData = selectedImage?.image?.jpegData(compressionQuality: 0.75) else { return }
        let updateMetaData = StorageMetadata.init()
        updateMetaData.contentType = " image/jpeg"
        
        imgRef.putData(imgData, metadata: updateMetaData) { (downloadMetadata, error) in
            if let error = error {
                print(error)
            } else {
                imgRef.downloadURL { (url, Error) in
                    let value = ["userID": userID, "toUserID" : toID,"audioName": audioName, "cardImageURL": url?.absoluteString] as [String: AnyObject]
                    
                    let ref = Database.database().reference(fromURL:"https://cardmakeroffice.firebaseio.com/")
                    let userRef = ref.child("SelectedCard")
                    let childRef = userRef.childByAutoId()
                    childRef.updateChildValues(value) { (err, ref) in
                        if err != nil {
                            print(err!)
                            return
                        }
                    }
                    let userMessagesRef = Database.database().reference(fromURL:"https://cardmakeroffice.firebaseio.com/").child("userMessages").child(userID)
                    guard let messageID = childRef.key else {return}
                    userMessagesRef.updateChildValues(["\(messageID)": 1]) { (err, dataref) in
                        if err != nil {
                            print(err!)
                            return
                        }
                    }
                    let recipientUserMessages = Database.database().reference().child("userMessages").child(toID)
                    recipientUserMessages.updateChildValues(["\(messageID)": 1])
                    print("Update CardDatabase Successfully")
                    
                }
                print("bo may load xong roi")
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        setSendButton()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setSendButton() {
        
        view.addSubview(sendButton)
        NSLayoutConstraint.activate([
            sendButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            sendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            sendButton.widthAnchor.constraint(equalToConstant: 100),
            sendButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(separatorView)
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: sendButton.topAnchor),
            separatorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            separatorView.widthAnchor.constraint(equalTo: view.widthAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 80)
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

