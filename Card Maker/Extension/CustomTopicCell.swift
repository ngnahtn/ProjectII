//
//  CustomTopicCell.swift
//  Invitation Maker
//
//  Created by Anh Tuan Ng on 10/9/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import FirebaseStorage

class TopicCell: UICollectionViewCell {
    weak var navigationController: UINavigationController?
    
    var page : TopicPage? {
        didSet {
            guard let unrappedPage = page else { return }
            let ref = Storage.storage().reference(withPath:  "/CardTopic/\(unrappedPage.pageImage).jpg")
            ref.getData(maxSize: 4*1024*1024) {[weak self] (data, error) in
                guard let sefll = self else {return}
                
                if let error = error {
                    print(error)
                    return
                }
                if let data = data {
                    sefll.topicButton.image = UIImage(data: data)?.withRenderingMode(.alwaysOriginal)
                    sefll.topicLable.text = unrappedPage.pageTopicName
                    sefll.topicLable.font = UIFont.init(name: "Palatino", size: 22)
                }
            }
            
        }
    }
    
    
    
    private var topicLable : UILabel = {
        let lable = UILabel()
        lable.backgroundColor = .clear
        lable.textColor = .white
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    private var topicButton: UIImageView = {
        let img = UIImage(named: "unknows_img")
        let imgView = UIImageView(image: img)
        imgView.isUserInteractionEnabled = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleToFill
        imgView.layer.cornerRadius = 0.5 * 30
        imgView.clipsToBounds = true
        imgView.alpha = 0.6
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
    
        ])
        
        addSubview(topicLable)
        NSLayoutConstraint.activate([
            topicLable.topAnchor.constraint(equalTo: topicButton.topAnchor,constant: 10),
            topicLable.trailingAnchor.constraint(equalTo: topicLable.trailingAnchor, constant: 0),
            topicLable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
        ])
    }
}
