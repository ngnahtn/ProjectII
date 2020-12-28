//
//  CardModel.swift
//  Card Maker
//
//  Created by Admin on 12/5/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit
import Firebase

class Card: NSObject {
    var userID: String?
    var toUserID: String?
    var imageURL: String?
    var audioNameString: String?
    var text: String?
    var textPositionX: CGFloat?
    var textPositionY: CGFloat?
    var textWidth: CGFloat?
    var textHeihgt: CGFloat?
    var textColor : String?

    
    func chatPartnerID() -> String? {
        if userID == Auth.auth().currentUser?.uid {
            return toUserID
        } else {
            return userID
        }
    }
}
