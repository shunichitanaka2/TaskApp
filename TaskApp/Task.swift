//
//  Task.swift
//  TaskApp
//
//  Created by 田中舜一 on 2016/08/03.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import RealmSwift

class Task: Object {
    
    dynamic var id = 0
    
    dynamic var title = ""
    
    dynamic var contents = ""
    
    dynamic var date = NSDate()
    
    dynamic var category = String()
    
    //dynamic var category:Category? = nil
    
    override static func primaryKey() -> String?{
        
        return "id"
    }
    
}

