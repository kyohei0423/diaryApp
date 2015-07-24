//
//  DetailDiaryViewController.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/10.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

class DetailDiaryViewController: UIViewController {
    
    var diary: Diary?
    

    @IBOutlet weak var detailTextView: UITextView!
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
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = diary?.date
        detailTextView.text = diary?.content
        
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
        }
    }
    
}
