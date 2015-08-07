//
//  NewDiaryViewController.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/10.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

//========プロトコルの作成===========
@objc protocol NewDiaryViewControllerDelegate {
    func newDiaryViewController(didSaveDiary vc:NewDiaryViewController, diary:Diary)
}

class NewDiaryViewController: UIViewController {
    
//========プロトコルとクラスの関連付け=========
    weak var delegate: NewDiaryViewControllerDelegate?
    
//========関連付け===========
    @IBOutlet weak var diaryTextView: UITextView!
    @IBOutlet weak var diaryTitle: UITextField!
    @IBOutlet weak var satisfactionSegment: UISegmentedControl!
    
//========プロパティ==========
    //DiaryStocksのインスタンスを生成することで日記を保存する配列にアクセスできるようになる
//    var diaryStocks = DiaryStocks.sharedInstance
    
    var diary: Diary!


    override func viewDidLoad() {
        super.viewDidLoad()
        satisfactionSegment.selectedSegmentIndex = 2
        //TextView
        diaryTextView.layer.cornerRadius = 8
        diaryTextView.layer.borderWidth = 3
        diaryTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    func save() {
        if count(diaryTextView.text) == 0 {
            showAlert("日記が入力されていません")
        } else {
            let diaryDate = Diary()
            diaryDate.title = diaryTitle.text
            diaryDate.content = diaryTextView.text
            diaryDate.satisfaction = satisfactionSegment.selectedSegmentIndex
            let date = day()
            diaryDate.date = date
            DiaryStocks.saveDiary(diaryDate)
            dismissViewControllerAnimated(true, completion: nil)
            self.delegate?.newDiaryViewController(didSaveDiary: self, diary: diaryDate)
        }
    }
    //保存に関するアラートを出す
    func showAlert(text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)
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
}
