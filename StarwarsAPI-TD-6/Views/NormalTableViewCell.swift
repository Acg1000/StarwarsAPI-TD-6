//
//  TableViewCell.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/12/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
// Function: Take the information modeled by the NormalCellViewModel and assign it to the actual labels and buttons...

import UIKit

class NormalTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "normalCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.098, green: 0.118, blue: 0.125, alpha: 1.00)
        selectedBackgroundView = backgroundView
    }
    
    func configure(with viewModel: NormalCellViewModel) {
        titleLabel.text = viewModel.title
        itemLabel.text = viewModel.item
    }
}
