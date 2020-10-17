//
//  CardSelectingViewController.swift
//  Invitation Maker
//
//  Created by Anh Tuan Ng on 10/9/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit

class CardSelectingViewController: UIViewController {
    
    lazy var backButton: UIButton = {
        let img = UIImage(named: "buttonicon_img")?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleTouchButton(_:)), for: .touchUpInside)
//        button.setTitle("Back", for: .normal)
        button.setImage(img, for: .normal)
        button.imageView?.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var appName : UILabel = {
        let lable = UILabel()
        lable.text = "Card Maker"
        lable.textColor = .red
        lable.font = UIFont.init(name: "LacostaPERSONALUSEONLY", size: 40)
        //        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        return lable
        
    }()
    
    lazy var welcomeImg: UIImageView = {
        let img = UIImage(named: "welcome_img")
        let imgView = UIImageView(image: img)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.148111701, green: 0.1289984584, blue: 0.1116550639, alpha: 1)
        view.addSubview(backButton)
        setConstrain()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setConstrain() {
        
        let headerView = UIView()
        headerView.backgroundColor = .clear
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        view.addSubview(welcomeImg)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.bottomAnchor.constraint(equalTo: welcomeImg.bottomAnchor)
        ])
        
       
        
        headerView.addSubview(appName)
        
        NSLayoutConstraint.activate([
            appName.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 20),
            appName.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            welcomeImg.topAnchor.constraint(equalTo: headerView.topAnchor,constant: 10),
            welcomeImg.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            welcomeImg.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
        ])
        
        let contentView = UIView()
        contentView.backgroundColor = .clear
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            backButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    //MARK: - target
    @objc func handleTouchButton(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
        
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
