//
//  CardCell.swift
//  Card Maker
//
//  Created by Admin on 11/10/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import FirebaseStorage

protocol GetImage: class {
    func fetchImage(image: UIImage?)
}


class CardCell: UICollectionViewCell {
    var image : UIImage?
    weak var delegate : GetImage?
    var cardsImage : imageNameArray? {
        didSet {
            guard let unrappedImageName = cardsImage else { return }
            let ref = Storage.storage().reference(withPath:  "/CardImage/\(unrappedImageName.imageName).jpg")
            ref.getData(maxSize: 4*1024*1024) {[weak self] (data, error) in
                guard let sefll = self else {return}
                
                if let error = error {
                    print(error)
                    return
                }
                if let data = data {
                    
                    sefll.image = UIImage(data: data)
                    sefll.cardImage.image = sefll.image
                    
                    
                }
            }
        }
    }
    
    private lazy var cardImage: UIImageView = {
        var img = UIImage(named: "b2")?.withRenderingMode(.alwaysOriginal)
        let imgView = UIImageView(image: img)
        imgView.contentMode = .scaleAspectFit
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapImage(_:))))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    @objc private func handleTapImage(_ sender: UIImage) {
        self.delegate?.fetchImage(image: self.image)
    }
    
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
