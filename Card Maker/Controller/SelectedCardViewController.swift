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
    var colors = Color()
    
    var fontString = "LacostaPERSONALUSEONLY"
    var textFontModel = TextFontModel()
    weak var navigation: UINavigationController?
    var musicStringName = ""
    var image = UIImageView()
    var textSize : CGFloat = 20
    var centerXConstraintofTextView1st: NSLayoutConstraint?
    var centerYConstraintofTextView1st: NSLayoutConstraint?
    var centerXConstraintofTextView2st: NSLayoutConstraint?
    var centerYConstraintofTextView2st: NSLayoutConstraint?
    private lazy var textView1st : UITextView = {
        let tv = UITextView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.isUserInteractionEnabled = true
        tv.backgroundColor = .clear
        
        tv.font = UIFont.init(name: "LacostaPERSONALUSEONLY", size: textSize)
        tv.layer.borderWidth = 1
        tv.layer.borderColor = UIColor.black.cgColor
        tv.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        tv.isScrollEnabled = false
        tv.delegate = self
        tv.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleTextView1Pan)))
        return tv
    }()
    @objc func tapDone(sender: Any) {
        self.textView1st.layer.borderColor = UIColor.clear.cgColor
        self.view.endEditing(true)
    }
    
    private lazy var colorChangedButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "color_icon")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(colorChangeButtonHandle(_ :)), for: .touchUpInside)
        return button
        
    }()
    private lazy var sizeChangedButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "size_img")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(sizeChangeButtonHandle(_ :)), for: .touchUpInside)
        return button
        
    }()
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "plus_img")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(plushnminusButtonHandle(_ :)), for: .touchUpInside)
        return button
        
    }()
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "minus_img")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(plushnminusButtonHandle(_ :)), for: .touchUpInside)
        return button
        
    }()
    private lazy var sizeView: UIView = {
        let subview = UIView()
        subview.backgroundColor = .clear
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.clipsToBounds = true
        subview.layer.cornerRadius = 10
        subview.isHidden = true
        return subview
    }()
    private func setSizeView() {
        view.addSubview(sizeView)
        NSLayoutConstraint.activate([
            sizeView.leftAnchor.constraint(equalTo: sizeChangedButton.leftAnchor, constant: -40),
            sizeView.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -5),
            sizeView.widthAnchor.constraint(equalTo: sizeChangedButton.widthAnchor,multiplier: 2),
            sizeView.heightAnchor.constraint(equalTo: sizeChangedButton.heightAnchor)
        ])
        let stackView = UIStackView(arrangedSubviews: [plusButton,minusButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        sizeView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: sizeView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: sizeView.rightAnchor),
            stackView.topAnchor.constraint(equalTo: sizeView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: sizeView.bottomAnchor)
            
        ])
    }
    private lazy var colorSelectingView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private lazy var textFontCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .blue
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isHidden = true
        collectionView.backgroundColor = .white
        return collectionView
    }()
    @objc func plushnminusButtonHandle(_ sender: UIButton) {
        if sender == plusButton {
            self.textSize += 1
            
        }else  {
            self.textSize -= 1
        }
        textView1st.font = UIFont.init(name: self.fontString, size: textSize)
        print(textSize)
    }
    @objc func sizeChangeButtonHandle(_ sender: UIButton) {
        colorSelectingView.isHidden = true
        textFontCollectionView.isHidden = true
        if sizeView.isHidden {
            sizeView.isHidden = false
            
        } else {
            sizeView.isHidden = true
        }
        
    }
    @objc func colorChangeButtonHandle(_ sender: UIButton) {
        sizeView.isHidden = true
        textFontCollectionView.isHidden = true
        if colorSelectingView.isHidden {
            colorSelectingView.isHidden = false
            
        } else {
            colorSelectingView.isHidden = true
        }
        
    }
    
    @objc func handleTextView1Pan(gesture : UIPanGestureRecognizer) {
        //
        guard gesture.view != nil else {return}
        //
        let translation = gesture.translation(in: self.view)
        //
        
        self.centerXConstraintofTextView1st?.constant += translation.x
        self.centerYConstraintofTextView1st?.constant += translation.y
        gesture.setTranslation(.zero, in: self.view)
        self.view.layoutIfNeeded()
        
        
    }
    
    func setTextViews() {
        view.addSubview(textView1st)
        self.centerXConstraintofTextView1st = textView1st.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        self.centerYConstraintofTextView1st = textView1st.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
        self.centerYConstraintofTextView1st?.priority = UILayoutPriority(rawValue: 999)
        self.centerXConstraintofTextView1st?.priority = UILayoutPriority(rawValue: 999)
        
        self.centerYConstraintofTextView1st?.isActive = true
        self.centerXConstraintofTextView1st?.isActive = true
        }
    
    private lazy var cardTemplate : UIImageView = {
        let imageView = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var frontChangedButton: UIButton = {
        let button = UIButton(type: .system)
        let img = UIImage(named: "font_img")?.withRenderingMode(.alwaysOriginal)
        button.setImage(img, for: .normal)
        button.addTarget(self, action: #selector(handleFontChangedButton(_ :)), for:.touchUpInside )
        button.imageView?.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    @objc func handleFontChangedButton(_ sender: UIButton) {
        sizeView.isHidden = true
        colorSelectingView.isHidden = true
        if textFontCollectionView.isHidden {
            textFontCollectionView.isHidden = false
            
        } else {
            textFontCollectionView.isHidden = true
        }
        
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
        cv.text = textView1st.text
        cv.textPosition = textView1st.frame
        cv.selectedImage = self.image
        cv.textSize = textSize
        cv.textColor = textView1st.textColor?.htmlRGBaColor
        cv.textFontString = self.fontString
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
        
        setTextViews()
     
        setButtonStack()
        setSizeView()
        textFontCollectionView.register(FontCell.self, forCellWithReuseIdentifier: "cellID1")
        colorSelectingView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID2")
        //        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleView)))
        
    }
    
    @objc func handleView() {
        [self.textView1st].forEach { $0.resignFirstResponder() }
        textView1st.layer.borderColor = UIColor.clear.cgColor
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
        let stackView = UIStackView(arrangedSubviews: [frontChangedButton,colorChangedButton,sizeChangedButton,sendButton])
        stackView.distribution = .fillEqually
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
        view.addSubview(colorSelectingView)
        NSLayoutConstraint.activate([
            colorSelectingView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            colorSelectingView.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
            colorSelectingView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            colorSelectingView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        ])
        view.addSubview(textFontCollectionView)
        NSLayoutConstraint.activate([
            textFontCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            textFontCollectionView.bottomAnchor.constraint(equalTo: separatorView.topAnchor,constant: -5),
            textFontCollectionView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            textFontCollectionView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
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
extension SelectedCardViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == textView1st {
            var frame = self.textView1st.frame
            frame.size.height = self.textView1st.contentSize.height
            frame.size.width = self.textView1st.contentSize.width
            self.textView1st.frame = frame
        
            textView1st.font = UIFont.init(name: fontString, size: textSize)
            //        } else {
            //            var frame = self.textView2st.frame
            //            frame.size.width = self.textView2st.contentSize.width
            //            frame.size.height = self.textView2st.contentSize.height
            //            self.textView2st.frame = frame
            //            textView2st.font = UIFont.init(name: "LacostaPERSONALUSEONLY", size: 20)
        }
        
    }
}

extension UIColor {
    var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0,0,0,0)
    }
    // hue, saturation, brightness and alpha components from UIColor**
    var hsbComponents:(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue:CGFloat = 0
        var saturation:CGFloat = 0
        var brightness:CGFloat = 0
        var alpha:CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha){
            return (hue,saturation,brightness,alpha)
        }
        return (0,0,0,0)
    }
    var htmlRGBColor:String {
        return String(format: "#%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255))
    }
    var htmlRGBaColor:String {
        return String(format: "#%02x%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255),Int(rgbComponents.alpha * 255) )
    }
    
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

// MARK: - UICollectionViewDelegate
extension SelectedCardViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDataSource
extension SelectedCardViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if traitCollection == colorChangedButton {
            return colors.colors.count
        } else {
            return textFontModel.textFonts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == colorSelectingView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID2", for: indexPath)
            let color = colors.colors[indexPath.item]
            cell.backgroundColor = color.colorArray
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = true
            cell.layer.borderColor = UIColor.black.cgColor

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID1", for: indexPath) as! FontCell
            let fontString = textFontModel.textFonts[indexPath.item]
            cell.textFont = fontString
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colorSelectingView {
        textView1st.textColor = self.colors.colors[indexPath.item].colorArray
        } else {
            self.fontString = self.textFontModel.textFonts[indexPath.item].font
            textView1st.font = UIFont.init(name: self.fontString, size: textSize)
        }
    }
    
    
}

extension SelectedCardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == colorSelectingView{
            return CGSize(width: 40, height: 40 )
        } else {
            return CGSize(width: textFontCollectionView.frame.height, height: textFontCollectionView.frame.height)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
}
extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
