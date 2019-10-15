//
//  ConvertableCellViewModel.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/13/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
// Function: Model the convertable cell...

import Foundation
import UIKit

class ConvertableCellViewModel {
    
    let title: String
    let item: Double
    var convertedItem: Double?
    var unit: StarwarsUnits
    let convertedUnit: StarwarsUnits
    var moneyConversionRatio: Double?
    
    init(title: String, item: Double, unit: StarwarsUnits, convertedUnit: StarwarsUnits ) {
        
        self.title = title
        self.unit = unit
        self.moneyConversionRatio = nil

        // if the cell's unit is in centimeters, like how the API returns the information, we know we need to convert to meters for display. Here we convert to meters and change the unit from cm to meters to keep track of that conversion. If its not in meters then we know it's in Galactic Credits so we don't need to convert.
        if unit == .centimeters {
            self.item = item / 100
            self.unit = .meters
            
        } else {
            self.item = item
            
        }
        
        // The converted unit is the unit that we are going to be converting to when the button is pressed.
        self.convertedUnit = convertedUnit
        
        // This code checks for the starting unit and the converted unit type to see what formula it needs to apply.
        if self.unit == .meters && convertedUnit == .feet {
            // convert from meters to feet
            self.convertedItem = self.item * 3.281
            
        } else if self.unit == .credits && convertedUnit == .USD {
            
            // convert from dollars to credits
            if self.moneyConversionRatio != nil {
                self.convertedItem = self.item / self.moneyConversionRatio!

            } else {
                // ADD SOMTHING ELSE HERE TO DISPLAY ERROR TO USER
                self.convertedItem = nil
            }
            
        } else {
            self.convertedItem = 0
            
        }
    }
    
    
    // This mutator function sets the conversion ratio for Galactic Credits to USD to what the user requests
    func setConversionRatio(to ratio: Double) {
        self.moneyConversionRatio = ratio
        self.convertedItem = self.item / self.moneyConversionRatio!
        
    }
}


// I extend the string method to add a little way to tell if a string can be converted to a double.
extension String {
    var isDouble: Bool {
        return Double(self) != nil
    }
}
