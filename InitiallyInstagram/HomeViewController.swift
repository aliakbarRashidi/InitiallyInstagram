//
//  HomeViewController.swift
//  InitiallyInstagram
//
//  Created by Anisha Gupta on 2/27/16.
//  Copyright © 2016 ani6gup. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

 
    @IBOutlet weak var tableView: UITableView!
    
    var picsPlusCaption: [PFObject]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 350
        self.tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("picture")
        query.findObjectsInBackgroundWithBlock { (results: [PFObject]?, error: NSError?) -> Void in
            if let error = error {
                print("Error: \(error)")
            } else {
                if let results = results {
                    print("Successfully retrieved \(results.count) posts")
                    
                    self.picsPlusCaption = results
                    for l in self.picsPlusCaption! {
                        print(l["caption"])
                        print(l["picture"])
                    }
                    self.tableView.reloadData()
                } else {
                    print("No results returned")
                }
            }
        }

    }

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
