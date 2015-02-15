//
//  FiltersController.swift
//  Project
//
//  Created by John Boggs on 2/13/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class FiltersController: UITableViewController {
    
    @IBOutlet weak var dealsSwitch: UISwitch!
    let DISTANCE_SECTION = 1
    let SORT_BY_SECTION = 2
    let CATEGORY_SECTION = 3

    let defaults = NSUserDefaults.standardUserDefaults()
    var dealsValue = NSUserDefaults.standardUserDefaults().boolForKey("dealsValue")
    var distanceSelection = NSUserDefaults.standardUserDefaults().integerForKey("distanceSelection")
    var sortBySelection = NSUserDefaults.standardUserDefaults().integerForKey("sortBySelection")
    
    
    @IBAction func dealsSwitchChanged(sender: AnyObject) {
        self.dealsValue = self.dealsSwitch.on
    }
    
    override func viewDidLoad() {
        self.dealsSwitch.on = self.defaults.boolForKey("dealsValue")
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)!
        switch indexPath.section {
        case DISTANCE_SECTION:
            self.distanceSelection = indexPath.row
        case SORT_BY_SECTION:
            self.sortBySelection = indexPath.row
        case CATEGORY_SECTION:
            ()
        default:
            ()
        }
        defaults.synchronize()
        self.tableView.reloadData()
    }
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        println("search button pressed")
        self.defaults.setBool(dealsValue, forKey: "dealsValue")
        self.defaults.setInteger(self.distanceSelection, forKey: "distanceSelection")
        self.defaults.setInteger(self.sortBySelection, forKey: "sortBySelection")
        self.defaults.synchronize()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtenPressed(sender: AnyObject) {
        println("cancel button pressed")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(self.tableView, cellForRowAtIndexPath: indexPath)
        if self.cellIsChecked(indexPath.section, row: indexPath.row) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        return cell
    }
    
    func cellIsChecked(section: Int, row: Int) -> Bool {
        var result = false
        switch section {
        case DISTANCE_SECTION:
            result = self.distanceSelection == row
        case SORT_BY_SECTION:
            result = self.sortBySelection == row
        case CATEGORY_SECTION:
            ()
        default:
            ()
        }
        return result
    }
}
