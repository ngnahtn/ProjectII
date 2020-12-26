//
//  NotifyCell.swift
//  Card Maker
//
//  Created by Admin on 12/26/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit

class NotifyCell: UITableViewCell {
    
    var user: User? {
        didSet {
            guard let userr = user else {return}
            
            let attributedText = NSMutableAttributedString(string: userr.name!, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
            attributedText.append(NSAttributedString(string: "\nsent you a card, let's see it in your message", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]))
            message.attributedText = attributedText
            message.numberOfLines = 0
            message.textColor = .black
        }
    }
    var notify : Notify? {
        didSet {
            guard let notifyy = notify else {return}
            if let seconds = notifyy.timestamp?.doubleValue {
                let timestampDate = NSDate(timeIntervalSince1970: seconds)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                timeLabel.text = dateFormatter.string(from: timestampDate as Date)
                
            }
            
        }
    }
    private lazy var userImage : UIImageView = {
        let image = UIImage(named: "user_img")?.withRenderingMode(.alwaysOriginal)
        let imgView = UIImageView(image: image)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    private lazy var timeLabel : UILabel = {
        let label = UILabel()
//        label.text = "HH:MM:SS"
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    private lazy var message : UILabel = {
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
        addSubview(message)
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: topAnchor),
            message.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 8),
            message.bottomAnchor.constraint(equalTo: bottomAnchor),
            message.rightAnchor.constraint(equalTo: rightAnchor,constant: -8)
            
        ])
        
        addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.rightAnchor.constraint(equalTo: rightAnchor,constant: -8),
            timeLabel.topAnchor.constraint(equalTo: topAnchor,constant: 30),
            timeLabel.heightAnchor.constraint(equalTo: textLabel!.heightAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
