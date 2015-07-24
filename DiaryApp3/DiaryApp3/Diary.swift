//
//  Diary.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/10.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

class Diary: NSObject {
   var content = ""
   var date = ""
    
    func convertDictionary() -> Dictionary<String, AnyObject> {
        var dic = Dictionary<String, AnyObject>()
        dic["content"] = self.content
        dic["date"] = self.date
        return dic
    }
    
    func update(attributes: Dictionary<String, AnyObject>) -> Diary {
        self.content = attributes["content"] as! String
        self.date = attributes["date"] as! String
        return self
    }
}


