//
//  Diary.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/10.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

//enum DaySatisfaction: Int {
//    case Poor = 0
//    case Bad = 1
//    case Average = 2
//    case Good = 3
//    case Excellent = 4
//    
//    func color() -> UIColor {
//        switch self {
//        case .Poor:
//            return UIColor.blackColor()
//        case .Bad:
//            return UIColor.blueColor()
//        case .Average:
//            return UIColor.greenColor()
//        case .Good:
//            return UIColor.yellowColor()
//        case .Excellent:
//            return UIColor.redColor()
//        }
//    }
//}

class Diary: NSObject {
    var title = ""
   var content = ""
    var satisfaction: Int!
   var date = ""
   var id: Int!
}


