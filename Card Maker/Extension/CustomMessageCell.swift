//
//  CustomMessageCell.swift
//  Card Maker
//
//  Created by Admin on 12/7/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage
import SDWebImage

class CustomMessageCell: UICollectionViewCell {

    var bubbleViewRightAnchor : NSLayoutConstraint?
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    var setCard : Card? {
        didSet {
            guard let cardImg = setCard else {return}
            guard let iamgeURLString = cardImg.imageURL else {return}
            let url = URL(string: iamgeURLString)
            if let imageURL = url {
                cardImageSent.sd_setImage(with: imageURL , completed: nil)
            }
        }
    }
    lazy var bubbleView: UIView = {
        let vieww = UIView()
        vieww.backgroundColor = UIColor(red: 0, green: 153, blue: 249)
        vieww.translatesAutoresizingMaskIntoConstraints = false
        vieww.layer.cornerRadius = 16
        vieww.clipsToBounds = true
        return vieww
    }()
    private lazy var cardImageSent: UIImageView = {
        let image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var textImage: UILabel = {
        let lable = UILabel()
        lable.text = "Abc"
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setImage() {
        addSubview(bubbleView)
        addSubview(cardImageSent)
        
        
        NSLayoutConstraint.activate([
            bubbleView.topAnchor.constraint(equalTo: topAnchor),
            bubbleView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
            bubbleView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: rightAnchor,constant: -10)
        bubbleViewRightAnchor?.isActive = true
        
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: leftAnchor,constant: 10)
        bubbleViewLeftAnchor?.isActive = true
        NSLayoutConstraint.activate([
            cardImageSent.topAnchor.constraint(equalTo: bubbleView.topAnchor,constant: 10),
            cardImageSent.leftAnchor.constraint(equalTo: bubbleView.leftAnchor,constant: 8),
            cardImageSent.rightAnchor.constraint(equalTo: bubbleView.rightAnchor,constant: -8),
            cardImageSent.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -10)
        ])
    }
}
