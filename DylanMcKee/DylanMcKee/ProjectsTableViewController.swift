//
//  ProjectsTableViewController.swift
//  DylanMcKee
//
//  Created by Dylan McKee on 18/04/2015.
//  Copyright (c) 2015 Dylan McKee. All  rights reserved.
//

import UIKit

class ProjectsTableViewController: UITableViewController {
    
    // a conveneince placeholder for the data to display
    let projects:Array<FeatureItem> = Data.getProjects()
    
    // a placeholder to hold tapped row index.
    private var selectedRowIndex:Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // evidently need navigation.
        self.navigationController?.navigationBarHidden = false
        
        self.title = "Projects"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return projects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("projectsCell", forIndexPath: indexPath) as! ProjectsTableViewCell

        // Configure the cell...
        
        cell.mainLabel.text = projects[indexPath.row].title
        
        cell.backgroundImageView.image = projects[indexPath.row].featuredImage

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // push seuge (after setting row index placeholder)
        selectedRowIndex = indexPath.row
        
    
        performSegueWithIdentifier("projectDetails", sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        var destination = segue.destinationViewController as! FeatureViewController
        // set FeatureViewController's data to display...
        destination.data = projects[selectedRowIndex!]
        
    }
    
    
    
    // this view controller should be portrait only!
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

}
