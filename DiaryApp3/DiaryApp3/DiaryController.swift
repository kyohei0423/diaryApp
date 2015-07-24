//
//  DiaryController.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/10.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

class DiaryController: NSObject {
    class func fetchDiaries() -> Array<Diary> {
        var diaries: [Diary] = []
        let defaults = NSUserDefaults.standardUserDefaults()
        if let diaryList = defaults.objectForKey("diaryLists") as? Array<Dictionary<String, AnyObject>> {
            for diaryDic in diaryList {
                let diary = Diary()
                diaries.append(diary.update(diaryDic))
            }
        }
        return diaries
    }
    
    class func save(diaries: Array<Diary>) {
        var diaryLists: Array<Dictionary<String, AnyObject>> = []
        for diary in diaries {
            var diaryDic = diary.convertDictionary()
            diaryLists.append(diaryDic)
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(diaryLists, forKey: "diaryLists")
    }
    
    
}
