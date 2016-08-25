//
//  InputViewController.swift
//  TaskApp
//
//  Created by 田中舜一 on 2016/08/03.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import UIKit
import RealmSwift

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentsTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var CategoryTextField: UITextField!
    
    let realm = try! Realm()
    
    //let Categoryrealm = try! Realm()
    
    //let CategoryArray = try! Realm().objects(Category)
    
    var task:Task!
    
    var category:Category!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //self.title = "abc"
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action:#selector(InputViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        
        
        titleTextField.text = task.title
        contentsTextView.text = task.contents
        datePicker.date = task.date
        CategoryTextField.text = task.category
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated:Bool){
        
        NSLog(self.titleTextField.text!)
        
        if self.titleTextField.text != "" {
            try! realm.write{
                self.task.title = self.titleTextField.text!
                self.task.contents = self.contentsTextView.text!
                self.task.date = self.datePicker.date
                self.task.category = self.CategoryTextField.text!
                self.realm.add(self.task!,update:true)
            }
            setNotification(task)
        }
        
        /*
        try! realm.write{
            self.task.title = self.titleTextField.text!
            self.task.contents = self.contentsTextView.text!
            self.task.date = self.datePicker.date
            self.task.category!.categoryname = self.CategoryTextField.text!
            self.realm.add(self.task!,update:true)
        }
        setNotification(task)
         */
        
        super.viewWillDisappear(animated)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func setNotification(task:Task){
        
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! {
            if notification.userInfo!["id"] as! Int == task.id {
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break   // breakに来るとforループから抜け出せる
            }
        }
        
        let notification = UILocalNotification()
        
        notification.fireDate = task.date
        notification.timeZone = NSTimeZone.defaultTimeZone()
        notification.alertBody = "¥(task.title)"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["id":task.id]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
    }
    
    @IBAction func back(segue:UIStoryboardSegue){//戻るボタン用
        print("back")
    }
    
    
    
    override func viewWillAppear(animated:Bool){
        super.viewWillAppear(animated)
        //CategoryRoll.reloadAllComponents()
    }


}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

