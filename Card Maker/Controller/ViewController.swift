//
//  ViewController.swift
//  Invitation Maker
//
//  Created by Anh Tuan Ng on 10/2/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    lazy var invitationCardImg: UIImageView = {
        let image = UIImage(named: "invitationCard_img")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var descriptionText: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Card Maker", attributes: [NSAttributedString.Key.font: UIFont.init(name: "LacostaPERSONALUSEONLY", size: 40) as Any])
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
        button.backgroundColor = UIColor(rgb: 0xff414d)
        button.setTitle("LET'S START", for: .normal)
        button.addTarget(self, action: #selector(handleTouchButton(_:)), for: .touchUpInside)
        button.layer.cornerRadius = 0.5 * 30
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.148111701, green: 0.1289984584, blue: 0.1116550639, alpha: 1)
        view.addSubview(descriptionText)
        view.addSubview(startButton)
       
        self.navigationController?.setNavigationBarHidden(true,animated: false)
        setTheConstraint()
    }
    
    // MARK: - setTheConstraint
    private func setTheConstraint() {
        
        let topImageView = UIView()
        view.addSubview(topImageView)
        topImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topImageView.topAnchor.constraint(equalTo:view.topAnchor),
            topImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)])
        
        topImageView.addSubview(invitationCardImg)
        
        // invitationCard
        NSLayoutConstraint.activate([
            invitationCardImg.centerXAnchor.constraint(equalTo: topImageView.centerXAnchor),
                                    
            invitationCardImg.centerYAnchor.constraint(equalTo: topImageView.centerYAnchor),
                                    
            invitationCardImg.heightAnchor.constraint(equalTo: topImageView.heightAnchor, multiplier: 0.5),
                                     
            invitationCardImg.bottomAnchor.constraint(equalTo: topImageView.bottomAnchor)])
        
        // descriptionText
        NSLayoutConstraint.activate([
        descriptionText.topAnchor.constraint(equalTo: topImageView.bottomAnchor),
        descriptionText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
        descriptionText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
        descriptionText.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // startButton
        NSLayoutConstraint.activate([
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
        startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
        startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
        startButton.heightAnchor.constraint(equalToConstant: 40)])
        
        
    }
    
    // MARK: - target
    @objc private func handleTouchButton(_ sender: UIButton) {
        let topicScreen = TopicScreenViewController()
        self.navigationController?.pushViewController(topicScreen, animated: true)
    }
    
   
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

