//
//  DiaryLsitTableTableViewController.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/10.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

class DiaryLsitTableTableViewController: UITableViewController,NewDiaryViewControllerDelegate {
    
//===============プロパティ定義======================
    //DiaryControllerがDiary（モデル）から取った値を入れるためのプロパティ
    var diaries:[Diary] = []
    
    var detailContent: String!
    var detailDate: String!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //データを入れる
       diaries = DiaryController.fetchDiaries()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//デリゲート
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showToDetailDiaryViewController"{
            let destinationViewController = segue.destinationViewController as! UINavigationController
            let detailDiaryViewController = destinationViewController.topViewController as! DetailDiaryViewController
            detailDiaryViewController.content = detailContent
            detailDiaryViewController.date = detailDate
        }   else {
            let destinationViewController = segue.destinationViewController as! UINavigationController
            let newDiaryViewController = destinationViewController.topViewController as! NewDiaryViewController
            newDiaryViewController.delegate = self
        }
    }
    
    func newDiaryViewController(didSaveDiary vc: NewDiaryViewController, diary: Diary) {
        self.diaries.append(diary)
        DiaryController.save(diaries)
        
        let alertView = UIAlertController(title: "日記を作成しました", message: "\(diary.date)の日記を作成しました", preferredStyle: UIAlertControllerStyle.Alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
        self.tableView.reloadData()
    }


//=============TableView==================
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diaries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("diaryIdentifier", forIndexPath: indexPath) as! UITableViewCell
        let diary = diaries[indexPath.row]
        
        var diaryLabel = cell.viewWithTag(1) as! UILabel
        diaryLabel.text = diary.content
        
        var dateLabel = cell.viewWithTag(2) as! UILabel
        dateLabel.text = diary.date

        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            self.diaries.removeAtIndex(indexPath.row)
            DiaryController.save(diaries)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
            return
        default:
            return
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let diary = diaries[indexPath.row]
        detailContent = diary.content
        detailDate = diary.date
        performSegueWithIdentifier("showToDetailDiaryViewController", sender: nil)
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
    }
    
    func new() {
        performSegueWithIdentifier("PresentNewDiaryViewController", sender: nil)
    }

}
