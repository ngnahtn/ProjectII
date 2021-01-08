//
//  CustomFlowLayout.swift
//  Card Maker
//
//  Created by Anh Tuan Ng on 10/23/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//
import UIKit

protocol CustomFlowLayoutDelegate: class {
    func collectionView(collectionView : UICollectionView, itemWidth: CGFloat, heightForIndexPath indexPath: NSIndexPath) -> CGFloat
    func getNumberOfCollum() -> Int
}
class CustomFlowLayout: UICollectionViewFlowLayout {
    var attributeArray = NSMutableDictionary()
    var contentSize : CGSize!
    weak var delegate : CustomFlowLayoutDelegate?
    override init() {
        super.init()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else {
            return
        }
        self.attributeArray.removeAllObjects()
        let numberOfCollum = delegate?.getNumberOfCollum()
        let padding : CGFloat = 30.0
        let collectionViewWidth : CGFloat =  collectionView.frame.size.width
        let itemWidth = (collectionViewWidth - padding * CGFloat(numberOfCollum! + 1))/CGFloat(numberOfCollum!)
        var collumArray = [CGFloat](repeating: 0.0, count: numberOfCollum!)
        var contentHeight : CGFloat = 0.0
        guard collectionView.numberOfItems(inSection: 0) > 0 else {return}
        for i in 0 ... (collectionView.numberOfItems(inSection: 0)) - 1 {
            var tempX : CGFloat = 0.0
            var minHeight : CGFloat = 0.0
            var minIndex : Int = 0
            var tempY : CGFloat = 0.0
            let itemHeight = delegate?.collectionView(collectionView: collectionView, itemWidth: itemWidth, heightForIndexPath: IndexPath(item: i, section: 0) as NSIndexPath)

            
            if numberOfCollum! > 0 {
                minHeight = collumArray[0]
            }
            for colIndex in 0 ..< numberOfCollum! {
                if (minHeight > collumArray[colIndex]) {
                    minHeight = collumArray[colIndex]
                    minIndex = colIndex
                }
            }
            tempX = padding + (itemWidth + padding) * CGFloat(minIndex)
            tempY = padding + minHeight
            collumArray[minIndex] = tempY + itemHeight!
            let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            attributes.frame = CGRect(x: tempX, y: tempY, width: itemWidth, height: itemHeight!)
            self.attributeArray.setObject(attributes, forKey: IndexPath(item: i, section: 0) as NSIndexPath)
            let newContentHeight : CGFloat = tempY + padding + itemHeight! + padding
            if newContentHeight > contentHeight {
                contentHeight = newContentHeight
            }
            self.contentSize = CGSize(width: collectionView.frame.size.width, height: contentHeight)
        }
    }
    override var collectionViewContentSize: CGSize {
        return self.contentSize ?? CGSize.zero
    }
    override func layoutAttributesForElements(in rect: CGRect) ->
        [UICollectionViewLayoutAttributes]? {
            var layoutAttributes = [UICollectionViewLayoutAttributes]()
            for attribute in self.attributeArray {
                if (attribute.value as! UICollectionViewLayoutAttributes).frame.intersects(rect) {
                    layoutAttributes.append(attribute.value as! UICollectionViewLayoutAttributes)
                }
            }
            return layoutAttributes
    }
}
