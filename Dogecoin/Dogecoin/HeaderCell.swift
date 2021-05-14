//
//  HeaderCell.swift
//  Dogecoin
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import UIKit

class HeaderCell: UITableViewCell {
    @IBOutlet weak var logoImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        logoImage.image = UIImage.init(named: "dogecoin")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
