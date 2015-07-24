//
//  DiaryLsitTableTableViewController.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/10.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

class DiaryLsitTableTableViewController: UITableViewController{

//===============プロパティ定義======================
    //DiaryControllerがDiary（モデル）から取った値を入れるためのプロパティ
    var diaries:[Diary] = []
    var diaryStocks = DiaryStocks.sharedInstance
    var currentDiary: Diary?

    override func viewDidLoad() {
        super.viewDidLoad()
        DiaryStocks.sharedInstance.getMyDiaries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        diaryLabel.text = myDiary.content
        
        var dateLabel = cell.viewWithTag(2) as! UILabel
        dateLabel.text = myDiary.date
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            diaryStocks.removeMyDiary(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
            return
        default:
            return
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
        self.tableView.reloadData()
    }
    
    func new() {
        performSegueWithIdentifier("PresentNewDiaryViewController", sender: nil)
    }
    
    @IBAction func unwindAction(segue: UIStoryboardSegue) {
        
    }

}
