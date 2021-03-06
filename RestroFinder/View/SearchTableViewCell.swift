//
//  SearchTableViewCell.swift
//  RestroFinder
//
//  Created by Harmeet Singh on 2021-08-01.
//  Copyright © 2021 Harmeet Singh. All rights reserved.
//

import UIKit
import Cosmos
import SDWebImage

/// Class for serach table view cell 
class SearchTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets for Xib objects
    @IBOutlet weak private var typesLabel: UILabel!
    @IBOutlet weak private var starView: CosmosView!
    @IBOutlet weak private var ratingLabel: UILabel!
    @IBOutlet weak private var imgView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var addressLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    // MARK: ReuseId for register cell in tableview
    static var reuseId: String {
        return String(describing: self)
    }
    
    // MARK: Set data in tableview row
    var business: Businesses? {
        didSet {
            guard let business = business else { return }
            titleLabel.text = business.name
            imgView.sd_setImage(with: business.imageURL)
            starView.rating = business.rating ?? 0
            ratingLabel.text = "\(business.review_count ?? 0) Reviews"
            priceLabel.text = business.price
            if let location = business.location, let address =  location.address1, let city =  location.city{
                addressLabel.text = "\(address), \(city)"
            }
            if let category = business.categories {
                var types = ""
                for index in 0...category.count - 1 {
                    types.append(category[index].title!)
                    if index < category.count - 1 {
                        types.append(", ")
                    }
                }
                typesLabel.text = types
            }
        }
    }
    
    // MARK: Set tableview height
    static var cellHeight: CGFloat {
        return UIScreen.mainSize.width * 0.4
    }
}
