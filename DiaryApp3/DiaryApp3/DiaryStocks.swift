//
//  DiaryStocks.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/11.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

class DiaryStocks: NSObject {
   static let sharedInstance = DiaryStocks()
    var myDiaries: Array<Diary> = []
    
    func addDiaryStocks(diary: Diary) {
        self.myDiaries.append(diary)
        println(diary.content)
        println(diary.date)
        saveDiary()
    }
    func saveDiary(){
        var tmpDiaries: Array<Dictionary<String, AnyObject>> = []
        for diary in self.myDiaries {
            var diaryDic = DiaryStocks.convertDictionary(diary)
            tmpDiaries.append(diaryDic)
        }
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(tmpDiaries, forKey: "myDiaries")
        defaults.synchronize()
    }
    
    
    class func convertDictionary(diary: Diary) -> Dictionary<String, AnyObject> {
        var dic = Dictionary<String, AnyObject>()
        dic["content"] = diary.content
        dic["date"] = diary.date
        return dic
    }
    
    func getMyDiaries() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let diaries = defaults.objectForKey("myDiaries") as? Array<Dictionary<String, String>> {
            for dic in diaries {
                var diary = DiaryStocks.convertDiaryModel(dic)
                self.myDiaries.append(diary)
            }
        }
    }
    
    class func convertDiaryModel(dic: Dictionary<String, String>) -> Diary {
        var diary = Diary()
        diary.content = dic["content"]!
        diary.date = dic["date"]!
        return diary
    }
    
    func removeMyDiary(index: Int) {
        self.myDiaries.removeAtIndex(index)
        saveDiary()
    }
    

}
