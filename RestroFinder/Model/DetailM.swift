//
//  DetailM.swift
//  RestroFinder
//
//  Created by Harmeet Singh on 2021-08-07.
//  Copyright © 2021 Harmeet Singh. All rights reserved.
//

import Foundation


import Foundation
import MapKit

struct DetailM : Codable {

    let photos : [String]?
    let coordinates: cordDetail?
}

struct cordDetail : Codable {

    let latitude : Double?
    let longitude : Double?
}
