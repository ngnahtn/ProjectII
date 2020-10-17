//
//  GreetingCustomCell.swift
//  Invitation Maker
//
//  Created by Anh Tuan Ng on 10/11/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit

class GreetingTopicCell: UICollectionViewCell {
    weak var navigationController: UINavigationController?
    
    lazy var topicLable : UILabel = {
        let lable = UILabel()
        lable.text = "GreaduationParty"
//        lable.font = UIFont.init(name: "Piazzolla", size: 24)
        lable.font = UIFont.boldSystemFont(ofSize: 24)
        lable.backgroundColor = .clear
        lable.textColor = .white
        
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        return lable
    }()
    lazy var topicButton: UIImageView = {
        let img = UIImage(named: "graduation_img")?.withRenderingMode(.alwaysOriginal)
        let imgView = UIImageView(image: img)
        imgView.isUserInteractionEnabled = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleToFill
//        imgView.contentMode = .top
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTouchButton(_:))))
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setButtonCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setButtonCell() {
        addSubview(topicButton)
        
        NSLayoutConstraint.activate([
            topicButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topicButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topicButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topicButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            topicButton.heightAnchor.constraint(equalTo: self.heightAnchor),
//            topicButton.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        addSubview(topicLable)
        NSLayoutConstraint.activate([
//            topicLable.topAnchor.constraint(equalTo: topicButton.bottomAnchor),
            topicLable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),

        ])
    }
    
    @objc func handleTouchButton(_ sender: UIButton) {
        let cardTopic = CardSelectingViewController()
        self.navigationController?.pushViewController(cardTopic, animated: true)
    }
}
