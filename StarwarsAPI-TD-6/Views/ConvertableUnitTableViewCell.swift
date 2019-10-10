//
//  ConvertableUnitTableViewCell.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/12/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

class ConvertableUnitTableViewCell: UITableViewCell {
    
    static let reuseIdentifer = "convertableUnit"
    
    var viewModel: ConvertableCellViewModel = {
        ConvertableCellViewModel(title: "", item: 0, unit: .centimeters, convertedUnit: .centimeters)
    }()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var conversionButton1: UIButton!
    @IBOutlet weak var conversionButton2: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.098, green: 0.118, blue: 0.125, alpha: 1.00)
        selectedBackgroundView = backgroundView
        // Configure the view for the selected state
    }
    
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
        
        conversionButton1.setTitle(viewModel.unit.rawValue, for: .normal)
        conversionButton2.setTitle(viewModel.convertedUnit.rawValue, for: .normal)
        conversionButton2.isEnabled = true
        
        conversionButton2.setTitleColor(.darkGray, for: .normal)
        conversionButton1.setTitleColor(.white, for: .normal)
        
        self.viewModel = viewModel
    }
    
    @IBAction func button1Pressed(_ sender: Any) {
        if viewModel.unit == .meters {
            if viewModel.item.isLess(than: 0.01) {
                itemLabel.text = "n/a"
                
            } else {
                itemLabel.text = String(format: "%.2fm", viewModel.item)

            }

        } else {
            itemLabel.text = String(viewModel.item.formatUsingAbbrevation())

        }

        conversionButton2.isEnabled = true
        conversionButton1.isEnabled = false
        
        conversionButton2.setTitleColor(.darkGray, for: .normal)
        conversionButton1.setTitleColor(.white, for: .normal)

    }
    
    @IBAction func button2Pressed(_ sender: Any) {
        
        if viewModel.unit == .meters {
            if viewModel.convertedItem.isLess(than: 0.01) {
                itemLabel.text = "n/a"

            } else {
                itemLabel.text = String(format: "%.2fft", viewModel.convertedItem)
                
            }

        } else {
            
            // Make a check to see if the conversion ratio exitst...
            let moneyConversionRatio = viewModel.moneyConversionRatio
            
            if moneyConversionRatio == nil {
                                
                // Call an alert controller at the information view controller
                let alertController = UIAlertController(title: "Enter Conversion Ratio", message: "Please enter the conversion ratio between USD and Galactic Credits as a percentage from Galactic Credits", preferredStyle: .alert)
                
                alertController.addTextField(configurationHandler: nil)
                
                alertController.addAction(UIAlertAction(title: "Submit", style: .default) { handler in
                    
//                    self.viewModel.setConversionRatio(to: alertController.textFields?[0].text)
                    self.checkConversionRatio(alertController.textFields?.first?.text)
                    self.itemLabel.text = String(self.viewModel.convertedItem.formatUsingAbbrevation())
                })
                
                UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                
            } else {
                itemLabel.text = String(viewModel.convertedItem.formatUsingAbbrevation())

            }
        }
        
        conversionButton2.isEnabled = false
        conversionButton1.isEnabled = true
        
        conversionButton1.setTitleColor(.darkGray, for: .normal)
        conversionButton2.setTitleColor(.white, for: .normal)
    }
    
    func checkConversionRatio(_ ratio: String?) {
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
