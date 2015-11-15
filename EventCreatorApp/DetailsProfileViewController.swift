//
//  DetailsProfileViewController.swift
//  EventCreatorApp
//
//  Created by Henok WeldeMicael on 11/15/15.
//  Copyright © 2015 Henok WeldeMicael. All rights reserved.
//

import UIKit
import Parse

class DetailsProfileViewController: UIViewController {

    var eventObject2 = PFObject(className: "Event")
    
    @IBOutlet var titleLabel: UILabel? = UILabel()
    @IBOutlet var descLabel: UILabel? = UILabel()
    @IBOutlet var timeLabel: UILabel? = UILabel()
    @IBOutlet var locationLabel: UILabel? = UILabel()
    @IBOutlet var costLabel: UILabel? = UILabel()
    @IBOutlet var foodLabel: UILabel? = UILabel()
    @IBOutlet var rsvpLabel: UILabel? = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel?.text = self.eventObject2.objectForKey("eventTitle") as? String
        self.descLabel?.text = self.eventObject2.objectForKey("eventDescription") as? String
        
        let dateOfEvent = self.eventObject2.objectForKey("eventDate") as! NSDate
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let dateString = dateFormatter.stringFromDate(dateOfEvent)
        
        self.timeLabel?.text = dateString
        
        self.locationLabel?.text = self.eventObject2.objectForKey("eventAddress") as? String
        self.costLabel?.text = String(self.eventObject2.objectForKey("cost")!)
        self.foodLabel?.text = self.eventObject2.objectForKey("foodDescription") as? String
        self.rsvpLabel?.text = "Number of RSVPs: \((self.eventObject2.objectForKey("rsvpList") as! NSArray).count)"
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
