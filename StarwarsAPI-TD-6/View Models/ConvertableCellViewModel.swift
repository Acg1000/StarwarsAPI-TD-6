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
    var convertedItem: Double
    var unit: StarwarsUnits
    let convertedUnit: StarwarsUnits
    var moneyConversionRatio: Double?
    
    init(title: String, item: Double, unit: StarwarsUnits, convertedUnit: StarwarsUnits ) {
        
        self.title = title
        self.unit = unit
        self.moneyConversionRatio = nil

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
            if self.moneyConversionRatio != nil {
                self.convertedItem = self.item / self.moneyConversionRatio!

            } else {
                // ADD SOMTHING ELSE HERE TO DISPLAY ERROR TO USER
                self.convertedItem = self.item / 100
            }
            
        } else {
            self.convertedItem = 0
        }
    }
    
    
    
    func setConversionRatio(to ratio: Double) {
        
//        guard let ratio = ratio else {
//            // ratio is nil
//            let alertController = UIAlertController(title: "No Conversion Ratio", message: "Please enter a valid INT conversion ratio", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//
//            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
//            return
//
//        }
//
//        // Check to make sure its an int
//        if (!ratio.isDouble) {
//            let alertController = UIAlertController(title: "Invalid Conversion Ratio", message: "Please enter a valid INT conversion ratio", preferredStyle: .alert)
//            alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//
//            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)

//        } else {
            self.moneyConversionRatio = ratio
            self.convertedItem = self.item / self.moneyConversionRatio!
//        }
    }
}


extension String {
    var isDouble: Bool {
        return Double(self) != nil
    }
}
