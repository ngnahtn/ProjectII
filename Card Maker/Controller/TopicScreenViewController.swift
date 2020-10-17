//
//  TopicScreenViewController.swift
//  Invitation Maker
//
//  Created by Anh Tuan Ng on 10/4/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit

class TopicScreenViewController: UIViewController {
    
    weak var navigation: UINavigationController?
    let cellID = "cellID"
    
    var invitationTopic = InvitationCard()
    var greetingTopic = GreetingCard()
    
    
    lazy var invitationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        
    }()
    
    lazy var greetingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        
    }()
    
    lazy var themeName: UILabel = {
        let lable = UILabel()
        lable.text = "Swipe right to select themes:"
        lable.font = UIFont.init(name: "Piazzolla", size: 30)
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        //        lable.font = UIFont.boldSystemFont(ofSize: 24)
        //        lable.textAlignment = .left
        return lable
    }()
    
    lazy var appName : UILabel = {
        let lable = UILabel()
        lable.text = "Card Maker"
        lable.textColor = UIColor(rgb: 0xff414d)
        lable.font = UIFont.init(name: "LacostaPERSONALUSEONLY", size: 40)
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        return lable
        
    }()
    
    lazy var invitationLable : UILabel = {
        let lable = UILabel()
        lable.text = "Invitation Card:"
        lable.textColor = .white
        lable.font = UIFont.boldSystemFont(ofSize: 24)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    } ()
    
    lazy var greetingLable : UILabel = {
        let lable = UILabel()
        lable.text = "Greeting Card:"
        lable.textColor = .white
        lable.font = UIFont.boldSystemFont(ofSize: 24)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    } ()
    
    lazy var welcomeImg: UIImageView = {
        let img = UIImage(named: "welcome_img")
        let imgView = UIImageView(image: img)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        invitationCollectionView.register(TopicCell.self, forCellWithReuseIdentifier: cellID)
        greetingCollectionView.register(TopicCell.self, forCellWithReuseIdentifier: cellID)
        greetingCollectionView.isPagingEnabled = true
        invitationCollectionView.isPagingEnabled = true
        view.backgroundColor = #colorLiteral(red: 0.148111701, green: 0.1289984584, blue: 0.1116550639, alpha: 1)
        setContentView()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - setContentView()
    
    
    fileprivate func setContentView() {
        
        
        
        
        // MARK: - headerView
        let headerView = UIView()
        headerView.backgroundColor = .clear
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        view.addSubview(welcomeImg)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.bottomAnchor.constraint(equalTo: welcomeImg.bottomAnchor)
        ])
        
        
        
        headerView.addSubview(appName)
        NSLayoutConstraint.activate([
            appName.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 20),
            appName.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            welcomeImg.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 10),
            welcomeImg.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            welcomeImg.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            
            
        ])
        // MARK: - contenView
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(contentView)
        view.addSubview(themeName)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -30),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant:-20),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            themeName.topAnchor.constraint(equalTo: contentView.topAnchor),
            themeName.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        contentView.addSubview(invitationLable)
        NSLayoutConstraint.activate([
            invitationLable.topAnchor.constraint(equalTo: themeName.bottomAnchor, constant: 40),
            invitationLable.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor)
        ])
        
        
        contentView.addSubview(invitationCollectionView)
        
        NSLayoutConstraint.activate([
            invitationCollectionView.topAnchor.constraint(equalTo: invitationLable.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            invitationCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            invitationCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            invitationCollectionView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
        ])
        
        contentView.addSubview(greetingLable)
        
        NSLayoutConstraint.activate([
            greetingLable.topAnchor.constraint(equalTo: invitationCollectionView.bottomAnchor, constant: 20),
            greetingLable.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 0)
        ])
        
        contentView.addSubview(greetingCollectionView)
        
        NSLayoutConstraint.activate([
            greetingCollectionView.topAnchor.constraint(equalTo: greetingLable.bottomAnchor, constant: 10),
            greetingCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            greetingCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            greetingCollectionView.heightAnchor.constraint(equalTo: invitationCollectionView.heightAnchor)
        ])
        
    }
    
}

// MARK: - UICollectionViewDelegate
extension TopicScreenViewController: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDataSource

extension TopicScreenViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if collectionView == invitationCollectionView {
            return invitationTopic.topic.count
        } else {
            return greetingTopic.topic.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TopicCell
        if collectionView == invitationCollectionView {
            
            let page = invitationTopic.topic[indexPath.item]
            cell.page = page
            return cell
        } else {
            let page = greetingTopic.topic[indexPath.item]
            cell.page = page
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(CardSelectingViewController(), animated: true)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension TopicScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: invitationCollectionView.frame.width, height: invitationCollectionView.frame.height)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


