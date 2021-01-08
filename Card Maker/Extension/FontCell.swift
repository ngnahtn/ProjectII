//
//  FontCell.swift
//  Card Maker
//
//  Created by Admin on 12/30/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit

class FontCell: UICollectionViewCell {
    var textFont: textFont? {
        didSet {
            guard let unrappedTextFont = textFont else {return}
            fontLabel.font = UIFont.init(name: unrappedTextFont.font, size: 30)
        }
    }
    
    private lazy var fontLabel: UILabel = {
        let label = UILabel()
        label.text = "Aa"
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setFontLabel()
        
    }
    private func setFontLabel() {
        addSubview(fontLabel)
        NSLayoutConstraint.activate([
            fontLabel.topAnchor.constraint(equalTo: topAnchor),
            fontLabel.leftAnchor.constraint(equalTo: leftAnchor),
            fontLabel.rightAnchor.constraint(equalTo: rightAnchor),
            fontLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
