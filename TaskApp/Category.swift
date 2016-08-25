//
//  Category.swift
//  TaskApp
//
//  Created by 田中舜一 on 2016/08/04.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import RealmSwift


class Category: Object{
    
    dynamic var id = 0
    
    dynamic var categoryname = ""
    
    
    override static func primaryKey() -> String?{
        
        return "id"
    }
    
    
    
}