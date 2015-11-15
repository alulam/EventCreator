//
//  DetailsViewController.swift
//  EventCreatorApp
//
//  Created by Henok WeldeMicael on 11/14/15.
//  Copyright © 2015 Henok WeldeMicael. All rights reserved.
//

import UIKit
import Parse

class DetailsViewController: UIViewController {

    var eventObject2 = PFObject(className: "Event")
    
    @IBOutlet var titleLabel: UILabel? = UILabel()
    @IBOutlet var descLabel: UILabel? = UILabel()
    @IBOutlet var timeLabel: UILabel? = UILabel()
    @IBOutlet var locationLabel: UILabel? = UILabel()
    @IBOutlet var costLabel: UILabel? = UILabel()
    @IBOutlet var foodLabel: UILabel? = UILabel()
    @IBOutlet var rsvpButton: UIButton! = UIButton()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.tintColor = UIColor.redColor()
        
        self.titleLabel?.text = self.eventObject2.objectForKey("eventTitle") as? String
        self.titleLabel!.font = UIFont.boldSystemFontOfSize(18.0)

        self.descLabel?.text = self.eventObject2.objectForKey("eventDescription") as? String
        
        let dateOfEvent = self.eventObject2.objectForKey("eventDate") as! NSDate
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy, hh:mm"
        
        let dateString = dateFormatter.stringFromDate(dateOfEvent)
        
        self.timeLabel?.text = dateString
        if(self.eventObject2.objectForKey("RmNumber")  as! String != "NA"){
            self.locationLabel?.text = "\(self.eventObject2.objectForKey("eventAddress")!), Room Number \(self.eventObject2.objectForKey("RmNumber")!)"
        }else{
            self.locationLabel?.text = self.eventObject2.objectForKey("eventAddress")! as? String
        }
        
        self.costLabel?.text = "$\(String(self.eventObject2.objectForKey("cost")!))"
        self.foodLabel?.text = self.eventObject2.objectForKey("foodDescription") as? String
        
        
        let rsvpersArray = self.eventObject2.objectForKey("rsvpList") as! NSArray
        
        
        
        if(rsvpersArray.containsObject((PFUser.currentUser()?.objectId)!)){
            
            self.rsvpButton.setTitle("Attending. Click to Un-Attend", forState: .Normal)
            
        }else{
            
            self.rsvpButton.setTitle("Not Attending. Click to Attend", forState: .Normal)
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rsvpActionPressed(sender: UIButton) {
        print("RSVP Pressed")
        
        //let eventObject = PFObject(className: "Event")
        
        let rsvpersArray = self.eventObject2.objectForKey("rsvpList") as! NSArray
        
        
       
        if(rsvpersArray.containsObject((PFUser.currentUser()?.objectId)!)){
            self.eventObject2.removeObject((PFUser.currentUser()?.objectId)!, forKey: "rsvpList")
            sender.setTitle("Not Attending. Click to Attend", forState: .Normal)
            
        }else{
            self.eventObject2.addObject((PFUser.currentUser()?.objectId)!, forKey: "rsvpList")
            sender.setTitle("Attending. Click to Un-Attend", forState: .Normal)
        }
        
        
        
        
        
        self.eventObject2.saveInBackgroundWithBlock { (bool: Bool, error: NSError?) -> Void in
            if(error == nil){
                print("RSVP Switch Saved")
            }else{
                print(error)
            }
        }
        
        
        
        
        
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
