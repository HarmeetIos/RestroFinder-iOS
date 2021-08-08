//
//  AbstractViewController.swift
//  RestroFinder
//
//  Created by Harmeet Singh on 2021-07-30.
//  Copyright © 2021 Harmeet Singh. All rights reserved.
//

import UIKit

class AbstractViewController: UIViewController {

    class var control: AbstractViewController {
        return UIStoryboard.main.instantiateViewController(withIdentifier: String(describing: self)) as! AbstractViewController
    }
}
