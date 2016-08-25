//
//  ViewController.swift
//  TaskApp
//
//  Created by 田中舜一 on 2016/08/03.
//  Copyright © 2016年 田中舜一. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    let realm = try! Realm()
    
    let taskArray = try! Realm().objects(Task).sorted("date",ascending:false)
    
    //var filteredTask = try! Realm().objects(Task).sorted("date",ascending:false)
    var filteredTask = [Task]()
    
    let searchViewController =  UISearchController(searchResultsController:nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        searchViewController.searchResultsUpdater = self
        searchViewController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchViewController.searchBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  filterContentForSearchText(searchText: String, scope: String = "ALL"){
        
        filteredTask = taskArray.filter{task in
            //return task.category.lowercaseString.containsString(searchText.lowercaseString)
            return task.category.lowercaseString == searchText.lowercaseString
        }
        tableView.reloadData()
        
    }
    
    

    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int{
        
        if searchViewController.active && searchViewController.searchBar.text != "" {
            return filteredTask.count
        }
        
        return taskArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell",forIndexPath: indexPath)
        
        let task:Task
        
        if searchViewController.active && searchViewController.searchBar.text != ""{
            task = filteredTask[indexPath.row]
            NSLog("filterd!!")
        }else{
            task = taskArray[indexPath.row]
        }
        
        
        //let task = taskArray[indexPath.row]
        cell.textLabel?.text = task.title
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.stringFromDate(task.date)
        cell.detailTextLabel?.text = dateString
        
        return cell
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle,forRowAtIndexPath indexPath :NSIndexPath){
        if editingStyle == UITableViewCellEditingStyle.Delete{
            
            let task = taskArray[indexPath.row]
            
            for notification in UIApplication.sharedApplication().scheduledLocalNotifications!{
                if notification.userInfo!["id"] as! Int == task.id{
                    UIApplication.sharedApplication().cancelLocalNotification(notification)
                    break
                }
                
            }
            
            try! realm.write{
                self.realm.delete(self.taskArray[indexPath.row])
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        performSegueWithIdentifier("cellSegue", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,sender: AnyObject?){
        let inputViewController: InputViewController = segue.destinationViewController as! InputViewController
        
        if segue.identifier == "cellSegue"{
            let indexPath = self.tableView.indexPathForSelectedRow
            inputViewController.task = taskArray[indexPath!.row]
        }else{
            let task = Task()
            task.date = NSDate()
            //task.category = Category()
            task.category = String()
            
            if taskArray.count != 0{
                task.id = taskArray.max("id")! + 1
            }
            
            inputViewController.task = task
        }

    }
    
    override func viewWillAppear(animated:Bool){
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    

}

extension ViewController:UISearchResultsUpdating{
    func updateSearchResultsForSearchController(searchController: UISearchController){
        filterContentForSearchText(searchController.searchBar.text!)
        //NSLog("filterText: \(searchController.searchBar.text!)")
        
    }
    
}



















