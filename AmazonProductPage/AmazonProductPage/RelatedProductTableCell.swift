//
//  RelatedProductTableCell.swift
//  AmazonProductPage
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import UIKit

class RelatedProductTableCell: UITableViewCell {
    @IBOutlet weak var relatedProductImage: UIImageView!
    @IBOutlet weak var relatedProductTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
