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
    
    @IBOutlet var tableView: UITableView!
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
                    self.tableView.reloadData()
                    
                }
                
               }else{
                print("No events found")
                
                
            }
        }
        
    }
    
    //******
    func signinUser(){
        
        //###########################################################################
        // Alert for Signing up or loggin in
        
        let alert:UIAlertController = UIAlertController(title: "Welcome", message: "You need to signup or login", preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            
            //********************************************************************
            
            let loginAlert:UIAlertController = UIAlertController(title: "Login", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            
            // Username textfield created with placeholder
            loginAlert.addTextFieldWithConfigurationHandler({
                
                textfield in
                textfield.placeholder = "Username"
                
            })
            
            // Password textfield created with placeholder
            loginAlert.addTextFieldWithConfigurationHandler({
                
                textfield in
                textfield.placeholder = "Password"
                textfield.secureTextEntry = true
                
            })
            
            // Action for Login button
            loginAlert.addAction(UIAlertAction(title: "Login", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                
                let textFields:NSArray = loginAlert.textFields! as NSArray
                
                let usernameTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
                let passwordTextField:UITextField = textFields.objectAtIndex(1)as! UITextField
                
                PFUser.logInWithUsernameInBackground(usernameTextField.text!, password: passwordTextField.text!){ (user:PFUser?, error:NSError?) -> Void in
                    
                    if((user) != nil){
                        print("Login success!")
                        
                        
                        
                    }else{
                        print(error)
                        let errorAlert:UIAlertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                        
                        errorAlert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
                            
                            self.presentViewController(loginAlert, animated: true, completion: nil)
                            
                        }))
                        
                        self.presentViewController(errorAlert, animated: true, completion: nil)
                    }
                    
                    
                    
                }
                
            }))
            self.presentViewController(loginAlert, animated: true, completion: nil)
            //********************************************************************
            
            
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Signup", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            //********************************************************************
            let signupAlert:UIAlertController = UIAlertController(title: "New Account", message: "Enter the following info to signup", preferredStyle: UIAlertControllerStyle.Alert)
            
            // Email textfield created with placeholder
            signupAlert.addTextFieldWithConfigurationHandler({
                
                textfield in
                textfield.placeholder = "Email"
                
            })
            
            // Username textfield created with placeholder
            signupAlert.addTextFieldWithConfigurationHandler({
                
                textfield in
                textfield.placeholder = "Username"
                
            })
            
            // Password textfield created with placeholder
            signupAlert.addTextFieldWithConfigurationHandler({
                
                textfield in
                textfield.placeholder = "Password"
                textfield.secureTextEntry = true
                
            })
            
            
            // Action for Login button
            signupAlert.addAction(UIAlertAction(title: "Signup", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                
                let textFields:NSArray = signupAlert.textFields! as NSArray
                
                let emailTextField:UITextField = textFields.objectAtIndex(0) as! UITextField
                let usernameTextField:UITextField = textFields.objectAtIndex(1)as! UITextField
                let passwordTextField:UITextField = textFields.objectAtIndex(2) as! UITextField
                
                
                let newUser:PFUser = PFUser()
                newUser.email = emailTextField.text
                newUser.username = usernameTextField.text
                newUser.password = passwordTextField.text
            
                newUser.signUpInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                    if(success){
                        print("New user created")
                    
                        
                        
                    }else{
                        print(error)
                        let errorAlert:UIAlertController = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                        
                        errorAlert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
                            
                            self.presentViewController(signupAlert, animated: true, completion: nil)
                            
                        }))
                        
                        self.presentViewController(errorAlert, animated: true, completion: nil)
                    }
                })
                
            }))
            self.presentViewController(signupAlert, animated: true, completion: nil)
            //********************************************************************
            
            
            
        }))
        
        
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        //###########################################################################
        
    }
    //******
    
    override func viewDidAppear(animated: Bool) {
        
        
       
        if(PFUser.currentUser() == nil){
            self.signinUser()
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(EventCell.self, forCellReuseIdentifier: "Cell")
        
        
        //self.tableView.delegate = self
        //self.tableView.dataSource = self
        

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
        //return 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        print("third")
        
        let cell:EventCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EventCell
        
        cell.eventTitleLabel.text = "Title1"
        cell.eventDescription.text = "Description1"

        
        return cell
    }

    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int
//    {
//        print("first")
//        return 1
//    }
    
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("second")
//        return eventsArray.count
//    }
//    
// 
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        print("third")
//        
//        
//        let cell:EventCell = self.tableView!.dequeueReusableCellWithIdentifier("Cell", forIndexPath:  indexPath) as! EventCell
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
//    
//    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
