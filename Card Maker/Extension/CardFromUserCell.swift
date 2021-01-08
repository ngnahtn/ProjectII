//
//  CardFromUserCell.swift
//  Card Maker
//
//  Created by Admin on 12/30/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SDWebImage

class CardFromUserCell: UICollectionViewCell {
    
    var card: Card? {
        didSet {
            guard let cardImg = card else {return}
            guard let iamgeURLString = cardImg.imageURL else {return}
            let url = URL(string: iamgeURLString)
            if let imageURL = url {
                cardImage.sd_setImage(with: imageURL , completed: nil)
            }
        }
        
    }
    private lazy var cardImage: UIImageView = {
        var img = UIImage(named: "b2")?.withRenderingMode(.alwaysOriginal)
        let imgView = UIImageView(image: img)
        imgView.contentMode = .scaleAspectFit
        imgView.isUserInteractionEnabled = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImgCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setImgCell() {
        addSubview(cardImage)
        
        NSLayoutConstraint.activate([
            cardImage.topAnchor.constraint(equalTo: topAnchor),
            cardImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardImage.leftAnchor.constraint(equalTo: leftAnchor),
            cardImage.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}

