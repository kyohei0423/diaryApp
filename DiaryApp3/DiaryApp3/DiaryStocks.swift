//
//  DiaryStocks.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/11.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit
import Alamofire

class DiaryStocks: NSObject {
    static let sharedInstance = DiaryStocks()
    var myDiaries: Array<Diary> = []
     class func saveDiary(diary: Diary) {
        var params: [String: AnyObject] = ["title": diary.title, "content": diary.content, "satisfaction": diary.satisfaction, "date": diary.date]
        // HTTP通信
        Alamofire.request(.POST, "http://localhost:3000/api/diaries", parameters: params, encoding: .URL).responseJSON { (request, response, JSON, error) in
            
//            println("=============request=============")
//            println(request)
//            println("=============response============")
//            println(response)
//            println("=============JSON================")
//            println(JSON)
//            println("=============error===============")
//            println(error)
//            println("=================================")
        }
    }
    
    class func getDiary(callBack: () -> Void) {
        Alamofire.request(.GET, "http://localhost:3000/api/diaries", parameters: nil,  encoding: .URL).responseJSON{ (request, response, JSON, error) in
            
//            println("=============JSON================")
//            println(JSON)
//            println("=============error===============")
//            println(error)
//            println("=================================")
            
            if error == nil {
                self.sharedInstance.myDiaries = []
                var diaries = JSON!["diaries"] as! Array<Dictionary<String, AnyObject>>
                println(diaries)
                println("===============取り出し==================")
                println(diaries[0])
                println("===============for in文==================")
                for diary in diaries {
                    let diaryData = Diary()
                    var title = diary["title"] as! String
                    var content = diary["content"] as! String
                    var satisfaction = diary["satisfaction"] as! Int
                    var date = diary["date"] as! String
                    var id = diary["id"] as! Int
                    
                    diaryData.title = title
                    diaryData.content = content
                    diaryData.satisfaction = satisfaction
                    diaryData.date = date
                    diaryData.id = id
                    self.sharedInstance.myDiaries.append(diaryData)
                }
                println(self.sharedInstance.myDiaries)
                callBack()
            }
        }
        
    }
    
    class func editDiary(diary: Diary) {
        var params: [String: AnyObject] = ["title": diary.title, "content": diary.content, "satisfaction": diary.satisfaction, "date": diary.date, "id": diary.id]
        Alamofire.request(.PUT, "http://localhost:3000/api/diaries/\(diary.id)", parameters: params, encoding: .URL).responseJSON { (request, response, JSON, error) in
            
            println("=============request=============")
            println(request)
            println("=============response============")
            println(response)
            println("=============JSON================")
            println(JSON)
            println("=============error===============")
            println(error)
            println("=================================")
        }
    }
    
    class func removeDiary(callBack: () -> Void, diary: Diary) {
        var params: [String: AnyObject] = ["id": diary.id]
        Alamofire.request(.DELETE, "http://localhost:3000/api/diaries/\(diary.id)", parameters: nil,  encoding: .URL).responseJSON{ (request, response, JSON, error) in
            println(diary.id)
            println("=============request=============")
            println(request)
            println("=============response============")
            println(response)
            println("=============JSON================")
            println(JSON)
            println("=============error===============")
            println(error)
            println("=================================")
        }
    }
}


    
//   static let sharedInstance = DiaryStocks()
//    var myDiaries: Array<Diary> = []
//
//    func addDiaryStocks(diary: Diary) {
//        self.myDiaries.append(diary)
//        println(diary.content)
//        println(diary.date)
//        saveDiary()
//    }
//    func saveDiary(){
//
//        var tmpDiaries: Array<Dictionary<String, AnyObject>> = []
//        for diary in self.myDiaries {
//            var diaryDic = DiaryStocks.convertDictionary(diary)
//            tmpDiaries.append(diaryDic)
//        }
//        let defaults = NSUserDefaults.standardUserDefaults()
//        defaults.setObject(tmpDiaries, forKey: "myDiaries")
//        defaults.synchronize()
//
//    }
//    class func convertDictionary(diary: Diary) -> Dictionary<String, AnyObject> {
//        var dic = Dictionary<String, AnyObject>()
//        dic["content"] = diary.content
//        dic["date"] = diary.date
//        return dic
//    }
//    
//    func getMyDiaries() {
//        let defaults = NSUserDefaults.standardUserDefaults()
//        if let diaries = defaults.objectForKey("myDiaries") as? Array<Dictionary<String, String>> {
//            for dic in diaries {
//                var diary = DiaryStocks.convertDiaryModel(dic)
//                self.myDiaries.append(diary)
//            }
//        }
//    }
//    
//    class func convertDiaryModel(dic: Dictionary<String, String>) -> Diary {
//        var diary = Diary()
//        diary.content = dic["content"]!
//        diary.date = dic["date"]!
//        return diary
//    }
//    
//    func removeMyDiary(index: Int) {
//        self.myDiaries.removeAtIndex(index)
//        saveDiary()
//    }