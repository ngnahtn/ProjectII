//
//  CellModel.swift
//  Invitation Maker
//
//  Created by Anh Tuan Ng on 10/11/20.
//  Copyright © 2020 Anh Tuan Ng. All rights reserved.
//

import UIKit

enum TopicCatagory {
    case weddingParty
    case birthdayParty
    case christmasParty
    case congratulation
    case fatherDay
    case motherDay
    case graduation
}

struct TopicPage {
    
    let pageImage: String
    let pageTopicName: String
    let topicCatagory: TopicCatagory
    let topicMusicName: String
    
    }

struct imageNameArray {
    let imageName : String
    }


