//
//  CategoryCreateView.swift
//  TaskApp
//
//  Created by 田中舜一 on 2016/08/04.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryCreateView: UIViewController {
    

    @IBOutlet weak var NewCategory: UITextField!

    
    let Categoryrealm = try! Realm()
    var category:Category!

    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self,action:#selector(CategoryCreateView.dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        self.category = Category()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillDisappear(animated:Bool){
        super.viewWillDisappear(animated)
    }
    

    func dismissKeyboard(){
        view.endEditing(true)
    }
    @IBAction func Enroll(sender: AnyObject) {
        
        try! Categoryrealm.write{
            
            //NSLog(self.NewCategory.text!)
            self.category!.categoryname = self.NewCategory.text!
            self.Categoryrealm.add(self.category!,update:true)
            let Cate = self.Categoryrealm.objects(Category)
            
            for cat in Cate{
                print("name: \(cat.categoryname)")
            }
            
        }
        
        
        NSLog("go!!")
    }

}
