//
//  DetailDiaryViewController.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/10.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

class DetailDiaryViewController: UIViewController,EditDiaryViewControllerDelegate {
    
    var diary: Diary?
    
    //=============関連付け================
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailSatisfaction: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TextView
        detailTextView.layer.cornerRadius = 8
        detailTextView.layer.borderWidth = 3
        detailTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).CGColor
        detailTextView.editable = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func editDiaryViewController(didSaveDiary vc: EditDiaryViewController) {
        //保存したことを伝えるアラートを出す
        let alertView = UIAlertController(title: "日記の編集を完了", message: "日記を編集をしました", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alertView, animated: false, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = diary?.date
        detailTitle.text = diary?.title
        detailTextView.text = diary?.content
        detailSatisfaction.selectedSegmentIndex = diary!.satisfaction
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: "edit")
    }
    
    func edit() {
        performSegueWithIdentifier("PresentToEditDiaryViewController", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PresentToEditDiaryViewController" {
            let destinationViewController = segue.destinationViewController as! UINavigationController
            let editDiaryViewController = destinationViewController.topViewController as! EditDiaryViewController
            editDiaryViewController.diary = self.diary
            editDiaryViewController.delegate = self
        }
    }
    
    //====================デリゲート=========================
    func editDiaryViewController(didSaveDiary vc: EditDiaryViewController, diary: Diary) {
        //保存したことを伝えるアラートを出す
        println("===============アラート=====================")
        println(diary.date)
        let alertView = UIAlertController(title: "日記をを編集", message: "\(diary.date)の日記を編集しました", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alertView, animated: false, completion: nil)
    }
}