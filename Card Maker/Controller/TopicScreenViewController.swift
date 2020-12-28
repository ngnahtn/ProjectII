//
//  TopicScreenViewController.swift
//  Invitation Maker
//
//  Created by Anh Tuan Ng on 10/4/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import Firebase

class TopicScreenViewController: UIViewController {
    
    
    weak var navigation: UINavigationController?
    let cellID = "cellID"
    
    var invitationTopic = InvitationCard()
    var greetingTopic = GreetingCard()
    
    
    
    // stack total
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var subStack1: UIStackView = {
        let subStack = UIStackView()
        subStack.backgroundColor = .clear
        subStack.axis = .vertical
        subStack.distribution = .fill
        subStack.addArrangedSubview(invitationLable)
        subStack.addArrangedSubview(invitationCollectionView)
        subStack.spacing = 10.0
        return subStack
    }()
    
    private lazy var subStack2: UIStackView = {
        let subStack = UIStackView()
        subStack.backgroundColor = .clear
        subStack.axis = .vertical
        subStack1.distribution = .fill
        subStack.addArrangedSubview(greetingLable)
        subStack.addArrangedSubview(greetingCollectionView)
        
        subStack.spacing = 10.0
        return subStack
    }()
    
    
    private lazy var invitationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        
    }()
    
    private lazy var greetingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
        
    }()
    
    private lazy var themeName: UILabel = {
        let lable = UILabel()
        lable.text = "Swipe right to select themes:"
        lable.font = UIFont.init(name: "Piazzolla", size: 30)
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        //        lable.font = UIFont.boldSystemFont(ofSize: 24)
        //        lable.textAlignment = .left
        return lable
    }()
    
    private lazy var appName : UILabel = {
        let lable = UILabel()
        lable.text = "Card Maker"
        lable.textColor = UIColor(rgb: 0xff414d)
        lable.font = UIFont.init(name: "LacostaPERSONALUSEONLY", size: 40)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textAlignment = .center
        return lable
        
    }()
    
    private lazy var invitationLable : UILabel = {
        let lable = UILabel()
        lable.text = "Invitation Card:"
        lable.textColor = .white
        lable.font = UIFont.boldSystemFont(ofSize: 24)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    } ()
    
    private lazy var greetingLable : UILabel = {
        let lable = UILabel()
        lable.text = "Greeting Card:"
        lable.textColor = .white
        lable.font = UIFont.boldSystemFont(ofSize: 24)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    } ()
    
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

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        invitationCollectionView.register(TopicCell.self, forCellWithReuseIdentifier: cellID)
        greetingCollectionView.register(TopicCell.self, forCellWithReuseIdentifier: cellID)
        greetingCollectionView.isPagingEnabled = true
        invitationCollectionView.isPagingEnabled = true
        view.backgroundColor = #colorLiteral(red: 0.148111701, green: 0.1289984584, blue: 0.1116550639, alpha: 1)
        setStackView()
        setTheContent()
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setTheContent() {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        headerView.addSubview(appName)
        headerView.addSubview(welcomeImg)
        headerView.addSubview(themeName)
        
        
        NSLayoutConstraint.activate([
            welcomeImg.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            welcomeImg.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            welcomeImg.topAnchor.constraint(equalTo: headerView.topAnchor),
            welcomeImg.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            appName.topAnchor.constraint(equalTo: headerView.topAnchor),
            appName.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            appName.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            appName.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            themeName.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            themeName.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            themeName.rightAnchor.constraint(equalTo: headerView.rightAnchor),
        ])
        
        self.contentStackView.addArrangedSubview(headerView)
        self.contentStackView.addArrangedSubview(subStack1)
        self.contentStackView.addArrangedSubview(subStack2)
        
        contentStackView.spacing = 30.0
        
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
    
    fileprivate func setStackView() {
        view.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        } else {
            let page = greetingTopic.topic[indexPath.item]
            cell.page = page
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cv = CardSelectingViewController()
        if collectionView == self.greetingCollectionView {
            cv.identyfi = self.greetingTopic.topic[indexPath.item].pageTopicName
            cv.musicName = self.greetingTopic.topic[indexPath.item].topicMusicName
        } else {
            cv.identyfi = self.invitationTopic.topic[indexPath.item].pageTopicName
            cv.musicName = self.invitationTopic.topic[indexPath.item].topicMusicName
        }
        
        self.navigationController?.pushViewController(cv, animated: true)
        print(cv.identyfi)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension TopicScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == invitationCollectionView {
            return CGSize(width: invitationCollectionView.frame.width, height: invitationCollectionView.frame.height)
        } else {
            return CGSize(width: greetingCollectionView.frame.width, height: greetingCollectionView.frame.height)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}



