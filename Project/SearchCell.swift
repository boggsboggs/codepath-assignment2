//
//  TableViewCell.swift
//  Project
//
//  Created by John Boggs on 2/13/15.
//  Copyright (c) 2015 Codepath. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var starsImageView: UIImageView!
    @IBOutlet weak var numReviewLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business : Business?
    var resultIndex: Int?
    
    func initialize() {
        if let business = self.business {
            nameLabel.text = "\(resultIndex! + 1). \(business.name)"
            addressLabel.text = business.address
            categoriesLabel.text = ", ".join(business.categories)
            numReviewLabel.text = "\(business.reviewCount) Reviews"
            businessImageView.setImageWithURL(business.imageUrl)
            starsImageView.setImageWithURL(business.ratingImageUrl)
        }
        self.setUpViews()
    }

    func setUpViews() {
        self.businessImageView.layer.cornerRadius = 5.0
        self.businessImageView.clipsToBounds = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
