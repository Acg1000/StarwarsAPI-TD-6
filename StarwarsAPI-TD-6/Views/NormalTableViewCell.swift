//
//  TableViewCell.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/12/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

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
    }
    
    func configure(with viewModel: NormalCellViewModel) {
        titleLabel.text = viewModel.title
        itemLabel.text = viewModel.item
    }
}
