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
    
    static func fromDictionary(dict: NSDictionary) -> Business {
        let name = dict["name"]! as String
        let locationDict = dict["location"]! as NSDictionary
        let address = (locationDict["address"]! as Array)[0] as String
        let reviewCount = dict["review_count"] as Int
        let imageUrl = NSURL(string: dict["image_url"]! as String)!
        let ratingImageUrl = NSURL(string: dict["rating_img_url_large"]! as String)!
        let categories = (dict["categories"]! as Array<Array<String>>).map({strArray in strArray[0]})
        
        return Business(
            name: name,
            address: address,
            reviewCount: reviewCount,
            imageUrl: imageUrl,
            ratingImageUrl: ratingImageUrl,
            categories: categories
        )
    }
}