//
//  SelectedCardViewController.swift
//  Card Maker
//
//  Created by Admin on 11/29/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import FirebaseStorage
import AVFoundation
import FirebaseDatabase

class SelectedCardViewController: UIViewController {
    var player : AVAudioPlayer!
    weak var navigation: UINavigationController?
    var musicStringName = ""
    var image = UIImageView()
    
    private lazy var cardTemplate : UIImageView = {
        let imageView = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var playMusicButton: UIButton = {
        let button = UIButton(type: .system)
        let img = UIImage(named: "musicicon")?.withRenderingMode(.alwaysOriginal)
        button.setImage(img, for: .normal)
        button.addTarget(self, action: #selector(handleMusicButton(_ :)), for:.touchUpInside )
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func handleMusicButton(_ sender: UIButton) {
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: musicStringName, ofType: "mp3")!)
                player = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
                player.prepareToPlay()
//                player.numberOfLoops = -1
                player.play()
                
    }
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        let img = UIImage(named: "sendicon")?.withRenderingMode(.alwaysOriginal)
        button.setImage(img, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(handleSendButton(_ :)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
        
    }()
    @objc func handleSendButton(_ sender: UIButton) {
        let cv = UserListTableViewController()
        cv.audioStringName = musicStringName
        cv.selectedImage = self.image
        self.navigationController?.pushViewController(cv, animated: true)
    }
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false,animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTheImage()
        setButtonStack()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true,animated: false)
    }

    private func setTheImage() {
        view.addSubview(cardTemplate)
        NSLayoutConstraint.activate([
            cardTemplate.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            cardTemplate.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cardTemplate.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cardTemplate.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier:3/4)
        ])
    }
    
    private func setButtonStack() {
        let vieww = UIView()
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [playMusicButton,vieww,sendButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        
        view.addSubview(stackView)
        view.addSubview(separatorView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cardTemplate.bottomAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            separatorView.topAnchor.constraint(equalTo: stackView.topAnchor,constant: -10),
            separatorView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            separatorView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
            
        ])
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
