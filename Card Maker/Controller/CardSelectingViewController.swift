//
//  CardSelectingViewController.swift
//  Invitation Maker
//
//  Created by Anh Tuan Ng on 10/9/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit

class CardSelectingViewController: UIViewController {
    let cellID = "CellID"
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var appName: UILabel = {
        let lable = UILabel()
        lable.textColor = UIColor(rgb: 0xff414d)
        lable.text = "Card Maker"
        lable.font = UIFont(name: "LacostaPERSONALUSEONLY", size: 40)
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.textAlignment = .center
        return lable
    }()
    private lazy var backButton: UIButton = {
        let img = UIImage(named: "buttonicon_img")?.withRenderingMode(.alwaysOriginal)
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(handleTouchButton(_:)), for: .touchUpInside)
        button.setImage(img, for: .normal)
        button.imageView?.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cardSellectingView: UICollectionView = {
        let layout = CustomFlowLayout()
        layout.delegate = self
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.148111701, green: 0.1289984584, blue: 0.1116550639, alpha: 1)
        view.addSubview(backButton)
        view.addSubview(contentStackView)
        cardSellectingView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        cardSellectingView.isPagingEnabled = true
        setConstrain()
        setCollectionView()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setCollectionView() {
        self.contentStackView .addArrangedSubview(appName)
        self.contentStackView .addArrangedSubview(cardSellectingView)
        self.contentStackView .addArrangedSubview(backButton)
        self.contentStackView.spacing = 20.0
        
        
    }
    
    fileprivate func setConstrain() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
// MARK: - UICollectionViewDelegate
extension CardSelectingViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension CardSelectingViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? .red: .green
        return cell
    }
    
    
}
// MARK: - CustomFlowLayoutDelegate
extension CardSelectingViewController: CustomFlowLayoutDelegate {
    func collectionView(collectionView: UICollectionView, itemWidth: CGFloat, heightForIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (cardSellectingView.frame.width)/3
    }
    
    func getNumberOfCollum() -> Int {
        return 2
    }
    
    
}
