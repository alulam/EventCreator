//
//  SearchViewController.swift
//  EventCreatorApp
//
//  Created by Henok WeldeMicael on 11/14/15.
//  Copyright © 2015 Henok WeldeMicael. All rights reserved.
//

import UIKit
import Parse

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    var eventsArray: NSMutableArray = NSMutableArray()
    
    
    func loadEventData(){
       self.eventsArray.removeAllObjects()
        
        let query = PFQuery(className: "Event")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, myerror: NSError?) -> Void in
            
            if(myerror == nil){
                print("found \(objects!.count) events")
                
                
                if let events = objects as? [PFObject]? {
                    
                    
                    for event in events! {
                        
                        self.eventsArray.addObject(event)
                    }
                    
                    
                }
                
               }else{
                print("No events found")
                
                
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView!.registerClass(EventCell.self, forCellReuseIdentifier: "groupcell")
        
        
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        

        // Do any additional setup after loading the view.
        
        
        self.loadEventData()
        
        
        
        
        
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (mysuccess: Bool, myerror: NSError? ) -> Void in
//            if(myerror==nil){
//            print("Object has been saved.")
//            }else{
//            print("error")
//            }
//            
//        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        print("first")
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("second")
        return eventsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                print("third")
        
        
        
                
                
                
                return UITableViewCell()

    }
    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        print("third")
//        
//        
//        let cell: EventCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath:  indexPath) as! EventCell
//        
//        
//        let event:PFObject = self.eventsArray.objectAtIndex(indexPath.row) as! PFObject
//        
//        print(event.objectForKey("eventTitle") as? String)
//        
////          cell.eventTitleLabel.text = event.objectForKey("eventTitle") as? String
////          cell.eventDescription.text = event.objectForKey("eventDescription") as? String
//        
//        cell.eventTitleLabel.text = "Title1"
//        cell.eventDescription.text = "Description1"
//        
//        
//        if(event.objectForKey("freeFood")?.boolValue == true ){
//            cell.foodButton.hidden = false
//        }
//        
//        
//        
//        
//        return cell
//    }
    
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
