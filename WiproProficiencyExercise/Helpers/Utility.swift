//
//  Utility.swift
//  WiproProficiencyExercise
//
//  Created by Kalyan Mannem on 12/12/19.
//  Copyright © 2019 CompIndia. All rights reserved.
//

import Foundation
import Reachability

class Utility: NSObject
{
    class func isConnectedtoNetwork() -> Bool{
        let reachability = try! Reachability()
        return reachability.connection != .unavailable
    }
}
