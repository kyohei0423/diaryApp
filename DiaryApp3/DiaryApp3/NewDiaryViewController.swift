//
//  NewDiaryViewController.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/10.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

//========プロトコル===========
@objc protocol NewDiaryViewControllerDelegate {
    func newDiaryViewController(didSaveDiary vc:NewDiaryViewController, diary: Diary)
}

class NewDiaryViewController: UIViewController {

//========関連付け===========
    @IBOutlet weak var diaryTextView: UITextView!
    
//========プロパティ==========
    var diary: Diary!
    
//========プロトコル型プロパティ==========
    weak var delegate: NewDiaryViewControllerDelegate?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diary = Diary()
        
        
        //TextView
        diaryTextView.layer.cornerRadius = 8
        diaryTextView.layer.borderWidth = 3
        diaryTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//=============Navigationbar===============
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //ボタン
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "save")
        
        //色
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    //閉じる
    func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //保存する
    func save() {
        if count(diaryTextView.text) == 0 {
            let alertView = UIAlertController(title: "エラー", message: "日記が入力されていません", preferredStyle: UIAlertControllerStyle.Alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertView, animated: true, completion: nil)
        } else {
            //入力された値をViewControllerに渡す
            diary.content = diaryTextView.text
            var date = day()
            diary.date = date
            
            self.delegate?.newDiaryViewController(didSaveDiary: self, diary: self.diary)
    
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func day() -> String {
        // 現在の時刻を取得
        let now = NSDate()
        // ユーザーのタイムゾーンのカレンダー
        let calendar = NSCalendar.currentCalendar()
        // 時刻から取得する要素
        let flag = NSCalendarUnit.CalendarUnitYear   |
            NSCalendarUnit.CalendarUnitMonth  |
            NSCalendarUnit.CalendarUnitDay
        
        // NSDateComponentsクラスのインスタンスを取得
        let components = calendar.components(flag, fromDate: now)
        // 年・月・日を取得
        let year   = components.year
        let month  = components.month
        let day    = components.day
    
        let saveDay = "\(year)年\(month)月\(day)日"
        // デバッグエリアに出力
        println("\(year)年\(month)月\(day)日")
    
        return saveDay
    }
    
//========お題を変える============
    

}
