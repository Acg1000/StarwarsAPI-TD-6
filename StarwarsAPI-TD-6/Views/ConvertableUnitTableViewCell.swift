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

        // Configure the view for the selected state
    }
    
    func configure(viewModel: ConvertableCellViewModel) {
        titleLabel.text = viewModel.title
        itemLabel.text = "\(viewModel.item)"
        
        
    }
}
