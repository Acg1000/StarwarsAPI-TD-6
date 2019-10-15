//
//  ConvertableUnitTableViewCell.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/12/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Function: Take the information modeled by the ConvertableCellViewModel and assign it to the actual labels and buttons...

import UIKit

class ConvertableUnitTableViewCell: UITableViewCell {
    
    static let reuseIdentifer = "convertableUnit"
    
    var viewModel: ConvertableCellViewModel = {
        ConvertableCellViewModel(title: "", item: 0, unit: .centimeters, convertedUnit: .centimeters)
    }()
    
    // Create outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var conversionButton1: UIButton!
    @IBOutlet weak var conversionButton2: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // Overriding the setSelected and making sure the background color does not change
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.098, green: 0.118, blue: 0.125, alpha: 1.00)
        selectedBackgroundView = backgroundView
        // Configure the view for the selected state
    }
    
    // MARK: Configure
    
    // configure method. Sets text and makes formatting decisions
    func configure(viewModel: ConvertableCellViewModel) {
        titleLabel.text = viewModel.title
        
        // if the item is pretty much 0, then it does not exist
        if viewModel.item.isLess(than: 0.01){
            itemLabel.text = "n/a"

        }
        
        // if the units are in meters then display them with an "m" after the number
        if viewModel.unit == .meters {
            itemLabel.text = String(format: "%.2fm", viewModel.item)

        // Otherwise, if they are in feet then display with ft afterwards
        } else if viewModel.unit == .feet {
            itemLabel.text = String(format: "%.2fft", viewModel.item)
            
        } else {
            itemLabel.text = String(viewModel.item.formatUsingAbbrevation())

        }
        
        // Set all the titles for the buttons depending on the units at hand
        conversionButton1.setTitle(viewModel.unit.rawValue, for: .normal)
        conversionButton2.setTitle(viewModel.convertedUnit.rawValue, for: .normal)
        conversionButton2.isEnabled = true
        
        // Set the starting colors
        conversionButton2.setTitleColor(.darkGray, for: .normal)
        conversionButton1.setTitleColor(.white, for: .normal)
        
        // Assign the view model
        self.viewModel = viewModel
    }
    
    
    // MARK: Button 1 Pressed
    
    @IBAction func button1Pressed(_ sender: Any) {
        // if the units are in meters make sure it's a reasonable number and assign it. If it's not then set the text to n/a
        if viewModel.unit == .meters {
            if viewModel.item.isLess(than: 0.01) {
                itemLabel.text = "n/a"
                
            } else {
                itemLabel.text = String(format: "%.2fm", viewModel.item)

            }

        } else {
            itemLabel.text = String(viewModel.item.formatUsingAbbrevation())

        }

        // Toggle the enabled buttons if button 2 is selected...
        conversionButton2.isEnabled = true
        conversionButton1.isEnabled = false
        
        // Also set their colors
        conversionButton2.setTitleColor(.darkGray, for: .normal)
        conversionButton1.setTitleColor(.white, for: .normal)

    }
    
    
    // MARK: Button 2 Pressed
    
    @IBAction func button2Pressed(_ sender: Any) {
        
        // Pretty much the same thing as the button 1 portion
        if viewModel.unit == .meters {
            
            if let convertedItem = self.viewModel.convertedItem {
                if convertedItem.isLess(than: 0.01) {
                    itemLabel.text = "N/A"

                } else {
                    itemLabel.text = String(format: "%.2fft", convertedItem)
                    
                    conversionButton2.isEnabled = false
                    conversionButton1.isEnabled = true
                   
                    conversionButton1.setTitleColor(.darkGray, for: .normal)
                    conversionButton2.setTitleColor(.white, for: .normal)
    
                }
            }
            
            
        } else {
            
            // Make a check to see if the conversion ratio exitst...
            let moneyConversionRatio = viewModel.moneyConversionRatio
            
            if moneyConversionRatio == nil {
                                
                // Call an alert controller at the information view controller
                let alertController = UIAlertController(title: "Enter Conversion Ratio", message: "Please enter the conversion ratio between USD and Galactic Credits as a percentage from Galactic Credits", preferredStyle: .alert)
                
                alertController.addTextField(configurationHandler: nil)
                
                let submitAction = UIAlertAction(title: "Submit", style: .default) { handler in
                    
                    self.setConversionRatio(alertController.textFields?.first?.text)
                    
                    if let convertedItem = self.viewModel.convertedItem {
                        self.itemLabel.text = String(convertedItem.formatUsingAbbrevation())

                        self.conversionButton2.isEnabled = false
                        self.conversionButton1.isEnabled = true
                           
                        self.conversionButton1.setTitleColor(.darkGray, for: .normal)
                        self.conversionButton2.setTitleColor(.white, for: .normal)
                        
                    } else {
                        // Don't change any text

                    }
                }
                
                alertController.addAction(submitAction)
                alertController.preferredAction = submitAction
                
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                                
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                
            } else {
                if let convertedItem = self.viewModel.convertedItem {
                    self.itemLabel.text = String(convertedItem.formatUsingAbbrevation())

                } else {
                    // Don't change any text

                }
                
                conversionButton2.isEnabled = false
                conversionButton1.isEnabled = true
                
                conversionButton1.setTitleColor(.darkGray, for: .normal)
                conversionButton2.setTitleColor(.white, for: .normal)

            }
        }
    }
    
    
    
    // MARK: Set Conversion Ratio
    
    func setConversionRatio(_ ratio: String?) {
        guard let ratio = ratio else{
            // There is nothing entered
            
            let alertController = UIAlertController(title: "No Conversion Ratio", message: "Please enter a valid INT conversion ratio", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
            return
        }
        
        if !ratio.isDouble {
            // ratio is not a double
            
            let alertController = UIAlertController(title: "Invalid Conversion Ratio", message: "Please enter a valid INT conversion ratio", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            
            UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        } else {
            
            if let ratioAsDouble = Double(ratio) {
                viewModel.setConversionRatio(to: ratioAsDouble)

            } else {
                
                fatalError()
            }
        }
    }
}



// MARK: Extensions
// I found this off StackOverflow. Its a nice way to format large numbers with letters! ITs nice because it allows me to present large numbers without overlaping with anything.

extension Double {

    func formatUsingAbbrevation () -> String {
        let numFormatter = NumberFormatter()

        typealias Abbrevation = (threshold:Double, divisor:Double, suffix:String)
        let abbreviations:[Abbrevation] = [(0, 1, ""),
                                           (1000.0, 1000.0, "K"),
                                           (100_000.0, 1_000_000.0, "M"),
                                           (100_000_000.0, 1_000_000_000.0, "B")]
                                           // you can add more !
        let startValue = Double (abs(self))
        let abbreviation:Abbrevation = {
            var prevAbbreviation = abbreviations[0]
            for tmpAbbreviation in abbreviations {
                if (startValue < tmpAbbreviation.threshold) {
                    break
                }
                prevAbbreviation = tmpAbbreviation
            }
            return prevAbbreviation
        } ()

        let value = Double(self) / abbreviation.divisor
        numFormatter.positiveSuffix = abbreviation.suffix
        numFormatter.negativeSuffix = abbreviation.suffix
        numFormatter.allowsFloats = true
        numFormatter.minimumIntegerDigits = 1
        numFormatter.minimumFractionDigits = 0
        numFormatter.maximumFractionDigits = 1

        return numFormatter.string(from: NSNumber (value:value))!
    }

}
