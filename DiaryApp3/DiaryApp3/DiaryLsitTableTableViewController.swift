//
//  DiaryLsitTableTableViewController.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/10.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

class DiaryLsitTableTableViewController: UITableViewController, NewDiaryViewControllerDelegate{

//===============プロパティ定義======================
    //DiaryControllerがDiary（モデル）から取った値を入れるためのプロパティ
    var diaries:[Diary] = []
    var diaryStocks = DiaryStocks.sharedInstance
    var currentDiary: Diary?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//====================デリゲート=========================
    func newDiaryViewController(didSaveDiary vc: NewDiaryViewController, diary: Diary) {
        //保存したことを伝えるアラートを出す
        println("===============アラート=====================")
        println(diary.date)
        let alertView = UIAlertController(title: "日記を作成", message: "\(diary.date)の日記を作成しました", preferredStyle: .Alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alertView, animated: false, completion: nil)
        self.tableView.reloadData()
    }
    
    
//=============TableView==================
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.diaryStocks.myDiaries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("diaryIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        let myDiary = self.diaryStocks.myDiaries[indexPath.row]
        var diaryLabel = cell.viewWithTag(1) as! UILabel
        diaryLabel.text = myDiary.title
        var dateLabel = cell.viewWithTag(2) as! UILabel
        dateLabel.text = myDiary.date
        
        func makePicture(x: String) -> UIImage {
            var picture = UIImage(named: x)
            return picture!
        }
        
        var icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        if var satisfaction = myDiary.satisfaction {
            if satisfaction == 4 {
                icon.image = makePicture("excellent")
            } else if satisfaction == 3 {
                icon.image = makePicture("good")
            } else if satisfaction == 2 {
                icon.image = makePicture("average")
            } else if satisfaction == 1 {
                icon.image = makePicture("bad")
            } else {
                icon.image = makePicture("veryBad")
            }
        }
        
//        var satisfactionIcon = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        satisfactionIcon.layer.cornerRadius = 10
//        if var satisfaction = myDiary.satisfaction{
//            if satisfaction == 4 {
//                satisfactionIcon.backgroundColor = UIColor.orangeColor()
//            } else if satisfaction == 3 {
//                satisfactionIcon.backgroundColor = UIColor.yellowColor()
//            } else if satisfaction == 2 {
//                satisfactionIcon.backgroundColor = UIColor.greenColor()
//            } else if satisfaction == 1 {
//                satisfactionIcon.backgroundColor = UIColor.blueColor()
//            } else {
//                satisfactionIcon.backgroundColor = UIColor.grayColor()
//            }
//        }
        cell.accessoryView = icon
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.currentDiary = diaryStocks.myDiaries[indexPath.row]
            let callBack = {() -> Void in
                self.tableView.reloadData()
            }
            diaryStocks.myDiaries.removeAtIndex(indexPath.row)
            DiaryStocks.removeDiary(callBack, diary: currentDiary!)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.currentDiary = diaryStocks.myDiaries[indexPath.row]
        performSegueWithIdentifier("showToDetailDiaryViewController", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showToDetailDiaryViewController"{
            let destinationViewController = segue.destinationViewController as! UINavigationController
            let detailDiaryViewController = destinationViewController.topViewController as! DetailDiaryViewController
            detailDiaryViewController.diary = self.currentDiary
        } else if segue.identifier == "PresentNewDiaryViewController"{
            let destinationViewController = segue.destinationViewController as! UINavigationController
            let newDiaryViewController = destinationViewController.topViewController as! NewDiaryViewController
            newDiaryViewController.delegate = self
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    
//==============Navigationbar=======================
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Plain, target: self, action: "new")
        self.navigationItem.leftBarButtonItem = editButtonItem()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let callBack = {() -> Void in
            self.tableView.reloadData()
        }
        DiaryStocks.getDiary(callBack)
        
    }
    
    func new() {
        performSegueWithIdentifier("PresentNewDiaryViewController", sender: nil)
    }
    
    @IBAction func unwindAction(segue: UIStoryboardSegue) {
        
    }

}
