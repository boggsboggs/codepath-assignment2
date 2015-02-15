//
//  SearchController.swift
//  Project
//
//  Created by John Boggs on 2/13/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class SearchController: UITableViewController, UISearchBarDelegate {
    var client: YelpClient!
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
    
    var businesses : Array<Business> = []
    let searchView = UISearchBar()
    var searchText = "Restaurant"
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var fetching = false
    @IBOutlet weak var businessImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = searchView
        searchView.delegate = self
        self.fetchBusinesses()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
        self.businesses = []
        self.fetchBusinesses()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let search = self.searchView.text
        println("Search Button Pressed: \(search)")
        self.searchText = search
        self.businesses = []
        self.fetchBusinesses()
        self.searchView.endEditing(true)
    }
    
    func fetchBusinesses(callback : (() -> ())? = nil) {
        self.fetching = true
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm(
            self.searchText,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("yelp fetch success")
                self.fetching = false
                self.businesses += (response["businesses"]! as Array).map(Business.fromDictionary)
                self.defaults.setInteger(self.businesses.count, forKey: "businessesOffset")
                self.tableView.reloadData()
            },
            { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
                self.fetching = false
            }
        )
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Do we need to fetch more data for infinite scroll?
        let resultIndex = indexPath.row
        if !self.fetching && self.businesses.count - resultIndex < 10 {
            self.fetchBusinesses()
        }
        let cell = self.tableView.dequeueReusableCellWithIdentifier("SearchCellIdentifier") as SearchCell
        cell.business = self.businesses[resultIndex]
        cell.resultIndex = resultIndex
        cell.initialize()
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.businesses.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "mapSegue" {
            let mapViewController = segue.destinationViewController as MapViewController
            mapViewController.businesses = self.businesses
        }
    }
    
}
extension Range {
    func map<R>(fn: T -> R) -> [R] {
        var dest = [R]()
        for item in self {
            dest.append(fn(item))
        }
        return dest
    }
}