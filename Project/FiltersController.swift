//
//  FiltersController.swift
//  Project
//
//  Created by John Boggs on 2/13/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class FiltersController: UITableViewController {
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        println("search button pressed")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtenPressed(sender: AnyObject) {
        println("cancel button pressed")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
