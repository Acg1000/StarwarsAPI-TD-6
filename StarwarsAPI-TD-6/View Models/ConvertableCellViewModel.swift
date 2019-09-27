//
//  ConvertableCellViewModel.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/13/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

//struct ConvertableCellViewModel {
//    let conversionType: StarwarsUnits
//
//    let title: String
//    let item: Double
//    var convertedItem = {
//        if conversionType == nil {
//            return
//        }
//    }
//
//    let unit: String
//    let convertedUnit: String
//
//}

class ConvertableCellViewModel {
    
    let title: String
    let item: Double
    let convertedItem: Double
    var unit: StarwarsUnits
    let convertedUnit: StarwarsUnits
    
    init(title: String, item: Double, unit: StarwarsUnits, convertedUnit: StarwarsUnits ) {
        
        self.title = title
        self.unit = unit

        if unit == .centimeters {
            self.item = item / 100
            self.unit = .meters
        } else {
            self.item = item
        }
        
        self.convertedUnit = convertedUnit
        
        if self.unit == .meters && convertedUnit == .feet {
            // convert from meters to feet
            self.convertedItem = self.item * 3.281
            
            print("Converted \(self.item) Meters to \(self.convertedItem)")

            
        } else if self.unit == .credits && convertedUnit == .USD {
            // convert from dollars to credits
            self.convertedItem = self.item / 100
            
        } else {
            self.convertedItem = 0
        }
    }
}
