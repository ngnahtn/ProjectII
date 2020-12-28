//
//  MusicCardViewController.swift
//  Card Maker
//
//  Created by Admin on 12/14/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import AVFoundation
import SDWebImage

class MusicCardViewControler: UIViewController {
    var player : AVAudioPlayer!
    var card = Card()
//    var audioString = ""
    weak var navigation: UINavigationController?
//    var imageURL = ""
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "LacostaPERSONALUSEONLY", size: 20)
        label.numberOfLines = 0
        label.textColor = UIColor(hex: card.textColor!)
        label.text = card.text!
        return label
    }()
    private lazy var cardTemplate : UIImageView = {
        let image = UIImage(named: "")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
        
        
 
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
//        guard let imageURL = card.imageURL else {return}
        guard let imageURL = card.imageURL, let positionX = card.textPositionX, let positionY = card.textPositionY, let width = card.textWidth, let height = card.textHeihgt else {
            return
        }
        view.backgroundColor = .white
        setTheImage()
        let url = URL(string: imageURL)
        cardTemplate.sd_setImage(with: url, completed: nil)
        textLabel.frame = CGRect(x: positionX, y: positionY, width: width, height: height)
        view.addSubview(textLabel)
        playMusic()
        
    }

    private func playMusic() {
        guard let audioString = card.audioNameString else {
            return
        }
        let AssortedMusics = NSURL(fileURLWithPath: Bundle.main.path(forResource: audioString, ofType: "mp3")!)
         player = try! AVAudioPlayer(contentsOf: AssortedMusics as URL)
         player.prepareToPlay()
         player.play()
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


