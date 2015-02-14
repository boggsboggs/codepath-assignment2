//
//  SearchController.swift
//  Project
//
//  Created by John Boggs on 2/13/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class SearchController: UITableViewController {
    var client: YelpClient!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    
    var businesses : Array<Business> = []
    
    @IBOutlet weak var businessImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.fetchBusinesses()
    }
    
    func fetchBusinesses() {
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(
            "store",
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                self.businesses = (response["businesses"]! as Array).map(Business.fromDictionary)
                println("yelp fetch success")
                self.tableView.reloadData()
            },
            { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
            }
        )
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SearchCellIdentifier") as SearchCell
        let resultIndex = indexPath.row
        cell.business = self.businesses[resultIndex]
        cell.resultIndex = resultIndex
        cell.initialize()
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses.count
    }
   
}
