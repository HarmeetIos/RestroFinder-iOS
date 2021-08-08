//
//  YelpManager.swift
//  RestroFinder
//
//  Created by Harmeet Singh on 2021-08-03.
//  Copyright © 2021 Harmeet Singh. All rights reserved.
//

import Alamofire

/// Class reponsible for fetch data from YELP API
class YelpManager {
 
    static func fetchYelpBusinesses(with offset: Int, location: String, completion: @escaping(_: BaseBusiness?) -> Void) {
        
        let parameters: Parameters = ["location": location,
                                      "offset": offset]
        
        let url = URL(string: "https://api.yelp.com/v3/businesses/search")
        
        // request from Alamofire
        APIManager.requestWith(url!, parameters: parameters) { (base: BaseBusiness?) in
            guard let baseModel = base else {
                completion(nil)
                return
            }
            completion(baseModel)
        }
    }
    
    static func fetchYelpBusinessesDetail(with id: String, completion: @escaping(_: DetailM?) -> Void) {
        
        let parameters: Parameters = ["locale": "en_US"]
        
        let url = URL(string: "https://api.yelp.com/v3/businesses/\(id)")
        
        APIManager.requestWith(url!, parameters: parameters) { (base: DetailM?) in
            guard let baseModel = base else {
                completion(nil)
                return
            }
            completion(baseModel)
        }
    }
}
