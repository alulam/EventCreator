//
//  ListViewController.swift
//  EventCreatorApp
//
//  Created by Henok WeldeMicael on 11/14/15.
//  Copyright © 2015 Henok WeldeMicael. All rights reserved.
//

import UIKit
import Parse

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var eventsArray:NSMutableArray = NSMutableArray()
    
    // Load
    func loadData(){
        // Initially, remove what is already there
       
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
                    self.tableView.reloadData()
                    
                }
                
            }else{
                print("No events found")
                
                
            }
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadData()
        
        self.tableView.registerClass(SingleCell.self, forCellReuseIdentifier: "groupcell")


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("YAY")
        let cell:SingleCell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! SingleCell
        
        let event:PFObject = self.eventsArray.objectAtIndex(indexPath.row) as! PFObject
        
        cell.titleLabel.text = event.objectForKey("eventTitle") as? String
        cell.descLabel.text = event.objectForKey("eventDescription") as? String
        
        
        if(event.objectForKey("freeFood")?.boolValue == true ){
            cell.foodButton.hidden = false
        }
        
        return cell
        
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
