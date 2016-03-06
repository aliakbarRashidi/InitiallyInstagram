//
//  HomeViewController.swift
//  InitiallyInstagram
//
//  Created by Anisha Gupta on 2/27/16.
//  Copyright © 2016 ani6gup. All rights reserved.
//

import UIKit
import Parse
//import MBProgressHUD

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

 
    @IBOutlet weak var tableView: UITableView!
    
    var picsPlusCaption: [PFObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .None
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // [query whereKey:@"UserID" equalTo:@"user"];

        let currentUser = PFUser.currentUser()
        let query = PFQuery(className: "Post")
        query.whereKey("user", equalTo: currentUser!)
        
        query.orderByDescending("createdAt")
        query.includeKey("picture")
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            if let error = error {
                print("Error: \(error)")
            } else {
                if let results = results {
                    
                    self.picsPlusCaption = results
                    
                     print("Successfully retrieved \(results.count) posts")
                    /*(for l in self.picsPlusCaption! {
                        print(l["caption"])
                        print(l["picture"])
                    }*/
                    self.tableView.reloadData()
                    self.tableView.separatorStyle = .None
                } else {
                    print("No results returned")
                }
            }
        }

    }
    
    /*func loadDataFromNetwork() {
        
        // ... Create the NSURLRequest (myRequest) ...
        
        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        // Display HUD right before the request is made
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(myRequest,
            completionHandler: { (data, response, error) in
                
                // Hide HUD once the network request comes back (must be done on main UI thread)
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                
                // ... Remainder of response handling code ...
                
        });
        task.resume()
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if self.picsPlusCaption != nil {
            return (self.picsPlusCaption?.count)!
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell", forIndexPath: indexPath) as! HomeCell
        
        cell.picsPlusCaption = picsPlusCaption[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {

           // picsPlusCaption.removeAtIndex(indexPath.row)
            //need to add in delete from parse inside here
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
