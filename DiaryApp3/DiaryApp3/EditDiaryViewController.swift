//
//  EditDiaryViewController.swift
//  DiaryApp3
//
//  Created by Seo Kyohei on 2015/07/11.
//  Copyright (c) 2015年 Kyohei Seo. All rights reserved.
//

import UIKit

//========プロトコルの作成===========
@objc protocol EditDiaryViewControllerDelegate {
    func editDiaryViewController(didSaveDiary vc:EditDiaryViewController, diary:Diary)
}

class EditDiaryViewController: UIViewController {
    //========プロトコルとクラスの関連付け=========
    weak var delegate: EditDiaryViewControllerDelegate?
    
    //================プロパティ=================================
    var diary :Diary!
    var diaries:[Diary] = []
    var diaryStocks = DiaryStocks.sharedInstance
    
    //===============関連付け======================
    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var editTextView: UITextView!
    @IBOutlet weak var editSatisfaction: UISegmentedControl!
    
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
        
        editTextField.text = diary.title
        editTextView.text = diary?.content
        editSatisfaction.selectedSegmentIndex = diary!.satisfaction
    
    }
    
    func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func save() {
        if count(editTextView.text) == 0 {
            showAlert("日記が入力されていません")
        } else {
            diary.title = editTextField.text
            diary.content = editTextView.text
            diary.satisfaction = editSatisfaction.selectedSegmentIndex
            DiaryStocks.editDiary(diary)
            dismissViewControllerAnimated(true, completion: nil)
            self.delegate?.editDiaryViewController(didSaveDiary: self, diary: diary)
        }
    }
    
    //保存に関するアラートを出す
    func showAlert(text: String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}