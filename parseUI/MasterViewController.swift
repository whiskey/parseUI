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
        
        setupParse()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        if let split = self.splitViewController {
//            let controllers = split.viewControllers
//            self.detailViewController = controllers[controllers.count-1].topViewController as? PushViewController
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Parse setup
    
    func setupParse() {
        var error: NSError?
        let path: NSString = NSBundle.mainBundle().pathForResource("localConfig", ofType: "json")!
        if (path.length == 0) {
            println("file localConfig.json not found")
            return
        }
        
        let jsonData: NSData = NSData.dataWithContentsOfFile(path, options:.DataReadingMappedIfSafe , error: &error)
        if (error != nil) {
            print(error)
            error = nil
        }
        if (jsonData.length > 0) {
            let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSDictionary
            let appID: String = jsonDict["parse.app.id"] as String
            let clientKey: String = jsonDict["parse.client.key"] as String
            Parse.setApplicationId(appID, clientKey: clientKey)
            println("init Parse")
        } else {
            println("no JSON data")
        }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navController = (segue.destinationViewController as UINavigationController)
        
        var vc: UIViewController!
        if segue.identifier == "showOldPush" {
            vc = UIViewController() //PushViewController()
            vc.view.backgroundColor = UIColor.redColor()
            vc.navigationItem.leftItemsSupplementBackButton = true
        } else if segue.identifier == "showPush" {
            vc = UIViewController()
            vc.view.backgroundColor = UIColor.greenColor()
            
        } else {
            assert(false, "mööp!")
        }
        
        if (vc != nil) {
            navController.addChildViewController(vc!)
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

