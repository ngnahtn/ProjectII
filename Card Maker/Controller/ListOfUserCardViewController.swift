//
//  ListOfUserCardViewController.swift
//  Card Maker
//
//  Created by Admin on 12/30/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase


class ListOfUserCardViewController: UIViewController {
    
    let cellID = "CellID"
    var cards = [Card]()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var appName: UILabel = {
        let lable = UILabel()
        lable.textColor = UIColor(rgb: 0xff414d)
        lable.text = "Card Maker"
        lable.font = UIFont(name: "LacostaPERSONALUSEONLY", size: 40)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textAlignment = .center
        return lable
    }()
    
    private lazy var backButton: UIButton = {
        let img = UIImage(named: "buttonicon_img")?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleTouchButton(_:)), for: .touchUpInside)
        button.setImage(img, for: .normal)
        button.imageView?.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var oldCardSellectingView: UICollectionView = {
        let layout = CustomFlowLayout()
        //        let layout = UICollectionViewFlowLayout()
        
        layout.delegate = self
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.148111701, green: 0.1289984584, blue: 0.1116550639, alpha: 1)
        view.addSubview(backButton)
        view.addSubview(contentStackView)
        self.oldCardSellectingView.register(CardFromUserCell.self, forCellWithReuseIdentifier: cellID)
        setConstrain()
        setCollectionView()
        observeImageFromeUser()
    }
    
    private func observeImageFromeUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("user-cards").child(uid).observe(.childAdded, with: { [weak self](snapshot) in
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
                card.textSize = dictionary["textSize"] as? CGFloat
                card.fontString = dictionary["fontasString"] as? String
                self.cards.append(card)
                DispatchQueue.main.async {
                    self.oldCardSellectingView.reloadData()
                }
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    fileprivate func setCollectionView() {
        self.contentStackView .addArrangedSubview(appName)
        self.contentStackView .addArrangedSubview(oldCardSellectingView)
        self.contentStackView .addArrangedSubview(backButton)
        self.contentStackView.spacing = 20.0
        
        
    }
    
    fileprivate func setConstrain() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - target
    @objc func handleTouchButton(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)

    }
    
}
// MARK: - UICollectionViewDelegate
extension ListOfUserCardViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                let cv = EdittedCardViewController()
                let card = cards[indexPath.item]
                cv.card = card
                navigationController?.pushViewController(cv, animated: true)
    
    }
}

extension ListOfUserCardViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - UICollectionViewDataSource
extension ListOfUserCardViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CardFromUserCell
        let card = cards[indexPath.item]
        cell.card = card
        return cell
    }
}
// MARK: - CustomFlowLayoutDelegate
extension ListOfUserCardViewController: CustomFlowLayoutDelegate {
    func collectionView(collectionView: UICollectionView, itemWidth: CGFloat, heightForIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (oldCardSellectingView.frame.width)/3
        //        return CGFloat(customCell.cardImage.frame.size.height)
    }
    
    func getNumberOfCollum() -> Int {
        return 2
    }
    
    
}
