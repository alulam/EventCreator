//
//  MyProfileViewController.swift
//  EventCreatorApp
//
//  Created by Henok WeldeMicael on 11/15/15.
//  Copyright © 2015 Henok WeldeMicael. All rights reserved.
//

import UIKit
import Parse


class MyProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var usernameLabel: UILabel! = UILabel()
    
    
    var eventsArray:NSMutableArray = NSMutableArray()
    var eventObject = PFObject(className: "Event")
    
    func loadData(){
        // Initially, remove what is already there
        
        self.eventsArray.removeAllObjects()
        
        let query = PFQuery(className: "Event")
        query.orderByDescending("createdAt")
        query.whereKey("creatorId", equalTo: (PFUser.currentUser()?.objectId)!)
        query.findObjectsInBackgroundWithBlock { (objects: [PFObject]?, myerror: NSError?) -> Void in
            
            if(myerror == nil){
                print("found \(objects!.count) of my events")
                
                
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
       
        
        self.loadData()
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.usernameLabel.text = "\((PFUser.currentUser()?.username)! as String)'s Events"
        self.usernameLabel.font = UIFont.boldSystemFontOfSize(18.0)

      

        
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
        
        let cell:ProfileViewCell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as! ProfileViewCell
        
        let event:PFObject = self.eventsArray.objectAtIndex(indexPath.row) as! PFObject
        
        cell.titleLabel!.text = event.objectForKey("eventTitle") as? String
        cell.titleLabel?.font = UIFont.boldSystemFontOfSize(18.0)

        cell.descLabel!.text = event.objectForKey("eventDescription") as? String
        
        
        if(event.objectForKey("freeFood")?.boolValue == true ){
            cell.foodButton?.hidden = false
        }
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showProfileEventDetails"){
            let controller = segue.destinationViewController as! DetailsProfileViewController
            controller.eventObject2 = self.eventObject
        }
        
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        self.eventObject = self.eventsArray.objectAtIndex(indexPath.row) as! PFObject
        self.performSegueWithIdentifier("showProfileEventDetails", sender: self)
        
    }
 
    @IBAction func refreshAction(sender: AnyObject) {
        self.loadData()
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
