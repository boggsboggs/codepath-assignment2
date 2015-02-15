//
//  YelpClient.swift
//  Yelp
//
//  Created by Timothy Lee on 9/19/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(
        term: String,
        success: (AFHTTPRequestOperation!, AnyObject!) -> Void,
        failure: (AFHTTPRequestOperation!, NSError!) -> Void
    ) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        
        var radiusFilter : Float?
        switch self.defaults.integerForKey("distanceSelection") {
        case 0:
            ()
        case 1:
            radiusFilter = 160
        case 2:
            radiusFilter = 480
        case 3:
            radiusFilter = 1600
        case 4:
            radiusFilter = 1600 * 5
        default:
            ()
        }
        
        var sort : String?
        switch self.defaults.integerForKey("sortBySelection") {
        case 0:
            sort = "0"
        case 1:
            sort = "1"
        case 2:
            sort = "2"
        default:
            ()
        }

        let dealsFilter = self.defaults.boolForKey("dealsValue")
        let offset = self.defaults.integerForKey("businessesOffset")
        var parameters = [
            "term": term,
            "location": "San Francisco",
            "deals_filter": "\(dealsFilter)",
            "offset": "\(offset)",
        ]
            
        if let sort = sort {
            parameters["sort"] = sort
        }
//        if let categoryFilter = categoryFilter {
//            parameters["category_filter"] = ",".join(categoryFilter)
//        }
        if let radiusFilter = radiusFilter {
            parameters["radius_filter"] = "\(radiusFilter)"
        }
        return self.GET(
            "search",
            parameters: parameters,
            success: success,
            failure: failure
        )
    }
    
    func getCategories() {
        let url = "https://raw.githubusercontent.com/Yelp/yelp-api/master/category_lists/en/category.json"
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(url))

        println("making categories request")
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler:{ (response, data, error) in
                var errorValue: NSError? = nil
                let responseJSON = NSJSONSerialization.JSONObjectWithData(
                    data, options: nil, error: &errorValue
                ) as NSArray
            }
        )
    }
    
    func restructureCategories(categoriesJSON: NSArray) {
        let categoriesDict = Dictionary<String, Dictionary<String, Dictionary<String, Array<String>?>?>?>()
        let categoryNameMap = Dictionary<String, String>()
        for category in categoriesJSON {
            let categories = (category as NSDictionary)["category"] as NSArray
            if categories.count > 0 {
                
            }
        }
    }
}