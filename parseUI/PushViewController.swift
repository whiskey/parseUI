//
//  PushViewController.swift
//  parseUI
//
//  Created by Carsten Witzke on 17/10/14.
//  Copyright (c) 2014 Secretescapes. All rights reserved.
//

import UIKit
import Parse

class PushViewController: UIViewController {

    @IBOutlet weak var alertTextView: UITextView!
    @IBOutlet weak var defaultSoundSwitch: UISwitch!
    @IBOutlet weak var backgroundPushSwitch: UISwitch!
    @IBOutlet weak var customPayloadTextView: UITextView!
    @IBOutlet weak var targetControl: UISegmentedControl!
    @IBOutlet weak var sendNotificationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertTextView.text = "test message \(NSDate())"
        customPayloadTextView.text = ""
        targetControl.selectedSegmentIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onChannelChange(sender: AnyObject) {
        println("selected \(targetControl.selectedSegmentIndex)")
    }
    
    // MARK: - push handling
    
    @IBAction func onSendPush(sender: AnyObject) {
        sendPush()
    }
    
    func sendPush() {
        // prepare standard push payload
        var push = PFPush()
        var data: [String: String] = Dictionary()
        if (alertTextView.text != nil) {
            data["alert"] = alertTextView.text
        }
        if (defaultSoundSwitch.enabled) {
            data["sound"] = "default"
        }
        if (backgroundPushSwitch.enabled) {
            data["content-available"] = "1"
        }
        print(data)
        assert(data.count>0, "no data given!")
        
        // custom payload data
        
        push.setData(data)
        
        // channels
        var channels = []
        switch targetControl.selectedSegmentIndex {
        case 1:
            channels = ["beta_testers", "devs"]
        default:
            channels = ["devs"]
        }
        push.setChannels(channels)
        
        // go!
        var error = NSErrorPointer()
        push.sendPushInBackgroundWithBlock { (success, error) -> Void in
            if error != nil {
                print(error)
            }
            if success {
                println("sending push notifications done: \(channels)")
            }
        }
    }

}
