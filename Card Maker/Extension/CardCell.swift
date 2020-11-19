//
//  CardCell.swift
//  Card Maker
//
//  Created by Admin on 11/10/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import FirebaseStorage
import Firebase

class CardCell: UICollectionViewCell {
    var identify = ""
    var cardsImage : imageNameArray? {
        didSet {
            guard let unrappedImageName = cardsImage else { return }
            let ref = Storage.storage().reference(withPath:  "/Graduation/\(unrappedImageName.imageName).jpg")
            ref.getData(maxSize: 4*1024*1024) { (data, error) in
                if let error = error {
                    print(error)
                    return
                }
                if let data = data {
                    self.cardImage.image = UIImage(data: data)
    //                    aArray[i] = data
//                    print(self.identify)
                    
                }
            }
        }
    }
    
    private var cardImage: UIImageView = {
        var img = UIImage(named: "b2")?.withRenderingMode(.alwaysOriginal)
        let imgView = UIImageView(image: img)
        imgView.contentMode = .scaleAspectFit
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
