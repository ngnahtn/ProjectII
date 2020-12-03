//
//  CardSelectingViewController.swift
//  Invitation Maker
//
//  Created by Anh Tuan Ng on 10/9/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit

class CardSelectingViewController: UIViewController, GetImage {
    
    
    func fetchImage(image: UIImage?) {
        let cv = SelectedCardViewController()
        cv.image.image = image!
        cv.musicStringName = self.musicName
        self.navigationController?.pushViewController(cv, animated: true)
    }
    
    weak var navigation: UINavigationController?
    var musicName = ""
    var identyfi : String = ""
    let cellID = "CellID"
    let customCell = CardCell()
    
    let birthdayImageNameArray = BirthdayPartyImageName()
    let weddingImageNameArray = WeddingPartyImageName()
    let christmasImageNameArray = ChristmasPartyImageName()
    let graduationImageNameArray = GraduationImageName()
    let motherDayImageNameArray = MothersDayImageName()
    let fatherDayImageNameArray = FathersDayImageName()
    
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
        cardSellectingView.register(CardCell.self, forCellWithReuseIdentifier: cellID)
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
        switch identyfi {
        case "Graduation":
            return graduationImageNameArray.imageName.count
        case "Father'sDay":
            return fatherDayImageNameArray.imageName.count
        case "Mother'sDay":
            return motherDayImageNameArray.imageName.count
        case "WeddingParty":
            return weddingImageNameArray.imageName.count
        case "BirthdayParty":
            return birthdayImageNameArray.imageName.count
        case "ChristmasParty":
            return christmasImageNameArray.imageName.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CardCell
        cell.delegate = self
        switch identyfi {
        case "Graduation":
            let cardsImageName = graduationImageNameArray.imageName[indexPath.item]
            cell.cardsImage = cardsImageName
            
        case "Father'sDay":
            let cardsImageName = fatherDayImageNameArray.imageName[indexPath.item]
            cell.cardsImage = cardsImageName
            

        case "Mother'sDay":
            let cardsImageName = motherDayImageNameArray.imageName[indexPath.item]
            cell.cardsImage = cardsImageName
            

        case "WeddingParty":
            let cardsImageName = weddingImageNameArray.imageName[indexPath.item]
            cell.cardsImage = cardsImageName
            

        case "BirthdayParty":
            let cardsImageName = birthdayImageNameArray.imageName[indexPath.item]
            cell.cardsImage = cardsImageName
            

        case "ChristmasParty":
            let cardsImageName = christmasImageNameArray.imageName[indexPath.item]
            cell.cardsImage = cardsImageName
            

        default:
            print("error")
        }

        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cv = SelectedCardViewController()
//        switch identyfi {
//        case "Graduation":
//            cv.imageName = birthdayImageNameArray.imageName[indexPath.item].imageName
//
//        case "Father'sDay":
//            cv.imageName = fatherDayImageNameArray.imageName[indexPath.item].imageName
//
//        case "Mother'sDay":
//            cv.imageName = motherDayImageNameArray.imageName[indexPath.item].imageName
//
//        case "WeddingParty":
//            cv.imageName = weddingImageNameArray.imageName[indexPath.item].imageName
//
//        case "BirthdayParty":
//            cv.imageName = birthdayImageNameArray.imageName[indexPath.item].imageName
//
//
//        case "ChristmasParty":
//            cv.imageName = christmasImageNameArray.imageName[indexPath.item].imageName
//
//
//        default:
//            print("error")
//        }
//        print(cv.imageName)
//        self.navigationController?.pushViewController(cv, animated: true)
//    }
    
    
}
// MARK: - CustomFlowLayoutDelegate
extension CardSelectingViewController: CustomFlowLayoutDelegate {
    func collectionView(collectionView: UICollectionView, itemWidth: CGFloat, heightForIndexPath indexPath: NSIndexPath) -> CGFloat {
        return (cardSellectingView.frame.width)/3
//        return CGFloat(customCell.cardImage.frame.size.height)
        }
    
    func getNumberOfCollum() -> Int {
        return 2
    }
    
    
}
