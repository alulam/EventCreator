//
//  AddNewEventViewController.swift
//  EventCreatorApp
//
//  Created by Henok WeldeMicael on 11/15/15.
//  Copyright © 2015 Henok WeldeMicael. All rights reserved.
//

import UIKit
import Parse

class AddNewEventViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var titleField: UITextField? = UITextField()
    @IBOutlet var descField: UITextField? = UITextField()
    
    @IBOutlet var dateField: UITextField? = UITextField()
    
    @IBOutlet var feeField: UITextField? = UITextField()
    @IBOutlet var foodField: UITextField? = UITextField()
    @IBOutlet var eventTypeField: UITextField? = UITextField()
    @IBOutlet var rmNumberField: UITextField? = UITextField()
    @IBOutlet var eventAddressField: UITextField? = UITextField()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleField?.delegate = self
        self.descField?.delegate = self
        self.dateField?.delegate = self
        self.feeField?.delegate = self
        self.foodField?.delegate = self
        self.eventTypeField?.delegate = self
        self.rmNumberField?.delegate = self
        self.eventAddressField?.delegate = self
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        print("Create Event Button Clicked")
        let newEvent = PFObject(className: "Event")
        newEvent["eventTitle"] = self.titleField?.text
        newEvent["eventDescription"] = self.descField?.text
        
        let dateString = self.dateField?.text
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let date = dateFormatter.dateFromString(dateString!)
        
        newEvent["eventDate"] = date
        
        
        
        
        newEvent["cost"] = self.feeField?.text
        if(foodField?.text == nil){
            newEvent["freeFood"] = false
            newEvent["foodDescription"] = ""
        }else{
            newEvent["freeFood"] = true
            newEvent["foodDescription"] = self.foodField?.text
        }
        let eventTypeValue = self.eventTypeField?.text
        if(eventTypeValue != "sport" && eventTypeValue != "student org" && eventTypeValue != "community"){
            newEvent["eventType"] = "default"
        }else{
            newEvent["eventType"] = eventTypeValue
        }
        if(self.rmNumberField!.text == nil){
            newEvent["RmNumber"] = "NA"
        }else{
            newEvent["RmNumber"] = self.rmNumberField?.text
        }
        newEvent["eventAddress"] = self.eventAddressField?.text
        
        newEvent["rsvpList"] = []
        
        newEvent["creatorId"] = PFUser.currentUser()?.objectId
        
        newEvent.saveInBackgroundWithBlock { (bool: Bool, myerror: NSError?) -> Void in
            if(myerror == nil){
                print("New Event Created")
            }else{
                print(myerror)
            }
        }
        
        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
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
