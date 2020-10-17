//
//  MainScreen.swift
//  Invitation Maker
//
//  Created by Anh Tuan Ng on 10/6/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import Foundation
import UIKit

struct  mainScreen {
     lazy var invitationCardImg: UIImageView = {
          let image = UIImage(named: "invitationCard_img")
          let imageView = UIImageView(image: image)
          imageView.translatesAutoresizingMaskIntoConstraints = false
          imageView.contentMode = .scaleAspectFit
          return imageView
      }()

     lazy var descriptionText: UITextView = {
          let textView = UITextView()
          let attributedText = NSMutableAttributedString(string: "InvitationMaker", attributes: [NSAttributedString.Key.font: UIFont.init(name: "LacostaPERSONALUSEONLY", size: 40) as Any])
          attributedText.append(NSAttributedString(string: "\n\nLet's customize your invitation more colorful. Join us for more.", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
          textView.attributedText = attributedText
          textView.backgroundColor = #colorLiteral(red: 0.148111701, green: 0.1289984584, blue: 0.1116550639, alpha: 1)
          textView.textColor = .white
          textView.translatesAutoresizingMaskIntoConstraints = false
          textView.textAlignment = .center
          textView.isEditable = false
          textView.isScrollEnabled = false
          return textView
      }()

      lazy var startButton : UIButton = {
          let button = UIButton(type: .custom)
          button.backgroundColor = #colorLiteral(red: 0.8692710996, green: 0.08593677729, blue: 0.2265800834, alpha: 1)
          button.setTitle("LET'S START", for: .normal)
          button.addTarget(self, action: #selector(handleTouchButton(_:)), for: .touchUpInside)
          button.translatesAutoresizingMaskIntoConstraints = false
          return button
      }()
    
    private func setTheConstraint() {
            
            let topImageView = UIView()
            view.addSubview(topImageView)
            topImageView.translatesAutoresizingMaskIntoConstraints = false
            topImageView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
            topImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            topImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            topImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
            
            topImageView.addSubview(invitationCardImg)
            
            invitationCardImg.centerXAnchor.constraint(equalTo: topImageView.centerXAnchor).isActive = true
            invitationCardImg.centerYAnchor.constraint(equalTo: topImageView.centerYAnchor).isActive = true
            invitationCardImg.heightAnchor.constraint(equalTo: topImageView.heightAnchor, multiplier: 0.5).isActive = true
            invitationCardImg.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor).isActive = true
            
            
            descriptionText.topAnchor.constraint(equalTo: topImageView.bottomAnchor).isActive = true
            descriptionText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
            descriptionText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
            descriptionText.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
            startButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
        }
        
        // MARK: - target
        @objc private func handleTouchButton(_ sender: UIButton) {
            let topicScreen = TopicScreenViewController()
            self.navigationController?.pushViewController(topicScreen, animated: true)
        }
    }


