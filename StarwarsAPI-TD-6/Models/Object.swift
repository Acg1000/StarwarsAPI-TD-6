//
//  Object.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/23/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

protocol Object {
    var type: StarwarsResource { get }
    
    var title: String { get }
    var sizeAttribute: Double { get }
    
    var attribute1: String { get }
    var arrtibute2: String { get }
    var attribute3: String { get }
    var attribute4: String { get }
    var attribute5: String { get }
    
}

// WORK ON FIXING THE INFORMATION VIEW CONTROLLER
