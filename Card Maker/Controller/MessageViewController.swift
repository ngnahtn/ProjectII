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

class MessageViewController: UIViewController {

    var blueColorCustomer = UIColor(red: 0, green: 137, blue: 249)
    var greyColorCustomer = UIColor(red: 240, green: 240, blue: 240)
    var text = ""
    var textPosition : CGRect?
    var textColor : String?
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
        guard let uid = Auth.auth().currentUser?.uid, let toID = user?.userID else {return}
        let userMessagesRef = Database.database().reference().child("userMessages").child(uid).child(toID)
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
                card.text = dictionary["text"] as? String
                card.textPositionX = dictionary["textPositionX"] as? CGFloat
                card.textPositionY = dictionary["textPostionY"] as? CGFloat
                card.textWidth = dictionary["textWidth"] as? CGFloat
                card.textHeihgt = dictionary["textHeight"] as? CGFloat
                card.textColor = dictionary["textColor"] as? String
                
                if card.chatPartnerID() == self.user?.userID {
                    self.cards.append(card)
                    DispatchQueue.main.async {
                        self.messageCollectionView.reloadData()
                        let indexPath = NSIndexPath(item: self.cards.count - 1, section: 0)
                        self.messageCollectionView.scrollToItem(at: indexPath as IndexPath, at: .bottom, animated: true)
                    }
                }
                
                
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    private lazy var messageCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 50
        layout.minimumLineSpacing = 50
        collectionView.contentInset = UIEdgeInsets.init(top: 12, left: 0, bottom: 58, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 50, right: 0)
        collectionView.collectionViewLayout = layout
        collectionView.alwaysBounceVertical = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
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
        guard let textFrame = textPosition, let color = textColor else {return}
        let imgRef = Storage.storage().reference(withPath: "/CardSelected/\(imageUUID).jpg")
        guard let imgData = selectedImage?.image?.jpegData(compressionQuality: 0.75) else { return }
        let updateMetaData = StorageMetadata.init()
        updateMetaData.contentType = " image/jpeg"
        let notifyID = UUID().uuidString
        let timestamp : NSNumber = NSNumber(value: Int(NSDate().timeIntervalSince1970))
        let userNotifyRef = Database.database().reference().child("user-notify").child(toID).child(notifyID)
        userNotifyRef.updateChildValues(["fromID" : userID, "timestamp" : timestamp]) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
        }
        imgRef.putData(imgData, metadata: updateMetaData) { (downloadMetadata, error) in
            if let error = error {
                print(error)
            } else {
                imgRef.downloadURL { (url, Error) in
                    let value = ["userID": userID, "toUserID" : toID,"audioName": audioName,"text": self.text, "textPositionX": textFrame.origin.x, "textPostionY": textFrame.origin.y, "textWidth" : textFrame.width,"textHeight": textFrame.height,"textColor": color,"cardImageURL": url?.absoluteString as Any] as [String: AnyObject]
                    
                    let ref = Database.database().reference(fromURL:"https://cardmakeroffice.firebaseio.com/")
                    let userRef = ref.child("SelectedCard")
                    let childRef = userRef.childByAutoId()
                    childRef.updateChildValues(value) { (err, ref) in
                        if err != nil {
                            print(err!)
                            return
                        }
                    }
                    let userMessagesRef = Database.database().reference(fromURL:"https://cardmakeroffice.firebaseio.com/").child("userMessages").child(userID).child(toID)
                    guard let messageID = childRef.key else {return}
                    userMessagesRef.updateChildValues(["\(messageID)": 1]) { (err, dataref) in
                        if err != nil {
                            print(err!)
                            return
                        }
                    }
                    let recipientUserMessages = Database.database().reference().child("userMessages").child(toID).child(userID)
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
        view.backgroundColor = .white
        messageCollectionView.backgroundColor = .white
        messageCollectionView.register(CustomMessageCell.self, forCellWithReuseIdentifier: "cellID")
        setSendButton()
        setCollectionView()
        
        
        
        //        let layout = UICollectionViewFlowLayout()
        //        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        //        layout.itemSize = CGSize(width: 100, height: 100)
        //        self.collectionView.collectionViewLayout = layout
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    private func setCollectionView() {
        view.addSubview(messageCollectionView)
        NSLayoutConstraint.activate([
            messageCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            messageCollectionView.bottomAnchor.constraint(equalTo: sendButton.topAnchor, constant: -8),
            messageCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            messageCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MessageViewController: UICollectionViewDelegate {
    
}

extension MessageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! CustomMessageCell
        let card = cards[indexPath.item]
        cell.setCard = card
        setCell(cell: cell, card: card)
        //        cell.
        return cell
    }
    func setCell(cell: CustomMessageCell, card : Card) {
        if card.userID == Auth.auth().currentUser?.uid {
            cell.bubbleViewRightAnchor?.isActive = true
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.bubbleView.backgroundColor = blueColorCustomer
        } else {
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
            cell.bubbleView.backgroundColor = greyColorCustomer
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = cards[indexPath.row]
//        guard let imageURLString = card.imageURL, let audioString = card.audioNameString else {
//            return
//        }
        let cv = MusicCardViewControler()
        cv.card = card
        self.navigationController?.pushViewController(cv, animated: false)
    }
}

extension MessageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 300)
    }
}

