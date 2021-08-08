//
//  Location.swift
//  RestroFinder
//
//  Created by Harmeet Singh on 2021-08-05.
//  Copyright © 2021 Harmeet Singh. All rights reserved.
//

import Foundation

struct Location : Codable {
    let address1 : String?
    let address2 : String?
    let address3 : String?
    let city : String?
    let zip_code : String?
    let country : String?
    let state : String?
    let display_address : [String]?
}
