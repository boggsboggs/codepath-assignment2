//
//  Business.swift
//  Project
//
//  Created by John Boggs on 2/13/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import Foundation


struct Business {
    var name: String
    var address: String
    var reviewCount: Int
    var imageUrl: NSURL
    var ratingImageUrl: NSURL
    var categories: Array<String>
    var lat: Double
    var long: Double
    
    static func fromDictionary(dict: NSDictionary) -> Business {
        let name = dict["name"]! as String
        let locationDict = dict["location"]! as NSDictionary
        var coordinates : Dictionary<String, Double>
        if let tmpCoordinates = locationDict["coordinate"] {
            coordinates = tmpCoordinates as Dictionary
        } else {
            coordinates = [
                "latitude": 0,
                "longitude": 0
            ]
        }
        let lat = coordinates["latitude"]!
        let long = coordinates["longitude"]!
        let addressArray = locationDict["address"]! as NSArray
        let address = addressArray.count > 0 ? addressArray[0] as String : ""
        
        let reviewCount = dict["review_count"] as Int
        println(dict)
        let imageUrl = NSURL(string: dict["image_url"]! as String)
        let ratingImageUrl = NSURL(string: dict["rating_img_url_large"]! as String)
        let categories = (dict["categories"]! as Array<Array<String>>).map({strArray in strArray[0]})

        
        return Business(
            name: name,
            address: address,
            reviewCount: reviewCount,
            imageUrl: imageUrl,
            ratingImageUrl: ratingImageUrl,
            categories: categories,
            lat: lat,
            long: long
        )
    }
}