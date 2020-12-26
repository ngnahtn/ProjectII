//
//  UserCell.swift
//  Card Maker
//
//  Created by Admin on 12/23/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    var user: User? {
        didSet {
            guard let userr = user else {return}
            userName.text = userr.name
            userName.textColor = .black
            userName.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    private lazy var userImage : UIImageView = {
        let image = UIImage(named: "user_img")?.withRenderingMode(.alwaysOriginal)
        let imgView = UIImageView(image: image)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private lazy var userName : UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setTheCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTheCell() {
        addSubview(userImage)
        NSLayoutConstraint.activate([
            userImage.topAnchor.constraint(equalTo: topAnchor),
            userImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            userImage.leftAnchor.constraint(equalTo: leftAnchor,constant: 8),
            userImage.widthAnchor.constraint(equalToConstant: frame.height*(userImage.frame.size.width/userImage.frame.size.height))
        ])
        addSubview(userName)
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: topAnchor),
            userName.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 8),
            userName.bottomAnchor.constraint(equalTo: bottomAnchor),
            userName.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
