//
//  MasterViewController.swift
//  parseUI
//
//  Created by Carsten Witzke on 17/10/14.
//  Copyright (c) 2014 Secretescapes. All rights reserved.
//

import UIKit
import Parse

class MasterViewController: UITableViewController {
    
    var detailViewController: PushViewController? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? PushViewController
        }
        
        setupParse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Parse setup
    
    func setupParse() {
        // TODO: get local config
        Parse.setApplicationId("", clientKey: "")
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                switch indexPath.row {
                case 0:
                    println("case 0")
                    break
                case 1:
                    println("case 1")
                    break
                default:
                    println("default")
                }
                
                let controller = (segue.destinationViewController as UINavigationController).topViewController as PushViewController
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return objects.count
//    }
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
//
//        let object = objects[indexPath.row] as NSString
//        cell.textLabel?.text = object
//        return cell
//    }

}

