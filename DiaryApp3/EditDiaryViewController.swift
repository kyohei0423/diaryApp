//
//  EditDiaryViewController.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/11.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

class EditDiaryViewController: UIViewController {
    var diary :Diary?
    var diaries:[Diary] = []
    var diaryStocks = DiaryStocks.sharedInstance
    
    @IBOutlet weak var editTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editTextView.layer.cornerRadius = 8
        editTextView.layer.borderWidth = 3
        editTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).CGColor

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: "save")
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        editTextView.text = diary?.content
    }
    
    func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func save() {
        if count(editTextView.text) == 0 {
        } else {
            diary?.content = editTextView.text
            self.diaryStocks.saveDiary()
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
}