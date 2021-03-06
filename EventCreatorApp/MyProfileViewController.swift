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
                print("Found \(objects!.count) of my events")
                
                
                if let events = objects as? [PFObject]? {
                    
                    
                    for event in events! {
                        
                        self.eventsArray.addObject(event)
                    }
                    self.tableView.reloadData()
                    
                }
                
            }else{
                print("No Events Found")
                
                
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
        super.viewDidAppear(true)
        
        self.loadData()
        
        if(PFUser.currentUser() == nil){
            self.signinUser()
        }else{
            print("Current User: \((PFUser.currentUser()?.username)!)")
        }
        
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
        }else{
            cell.foodButton?.hidden = true
        }
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let currentuser = PFUser.currentUser()
        
        
            
            let delete = UITableViewRowAction(style: .Normal, title: "Delete") { action, index in
                print("Delete Button Clicked")
                
                if(currentuser != nil){
                    
                    let event:PFObject = self.eventsArray.objectAtIndex(indexPath.row) as! PFObject
                    
                    event.deleteInBackgroundWithBlock({ (bool, error) -> Void in
                        
                        if(error == nil){
                            print("User Event Deleted!")
                            self.loadData()
                        }else{
                            print("Error Deleting Event")
                        }
                        
                    })
                }
            }
            
            delete.backgroundColor = UIColor.redColor()
            
            return [delete]
      
        
    }//swipe
    
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
    
    
    @IBAction func logoutAction(sender: AnyObject) {
        
        PFUser.logOutInBackgroundWithBlock { (myerror: NSError?) -> Void in
            if(myerror == nil){
                print("Logged Out")
            }else{
                print(myerror)
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
