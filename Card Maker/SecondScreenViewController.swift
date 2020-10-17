//
//  SecondScreenViewController.swift
//  Invitation Maker
//
//  Created by Anh Tuan Ng on 10/4/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit

class SecondScreenViewController: UIViewController {

    private lazy var button : UIButton = {
        let buttonn = UIButton(type: .system)
        buttonn.backgroundColor = .white
        buttonn.setTitle("abc", for: .normal)
        buttonn.addTarget(self, action: #selector(handleTouchButton(_:)), for: .touchUpInside)
        buttonn.translatesAutoresizingMaskIntoConstraints = false
        return buttonn
    }()
    
    lazy var appName : UILabel = {
        let lable = UILabel()
        lable.text = "Invitation Maker"
        lable.textColor = .white
        lable.font = UIFont.init(name: "LacostaPERSONALUSEONLY", size: 40)
        lable.translatesAutoresizingMaskIntoConstraints = false
        
        return lable
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.148111701, green: 0.1289984584, blue: 0.1116550639, alpha: 1)
        view.addSubview(button)
        view.addSubview(appName)
        setContraint()
        // Do any additional setup after loading the view.
    }
    
    @objc func handleTouchButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    fileprivate func setContraint() {
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
    
        appName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        appName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        
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
