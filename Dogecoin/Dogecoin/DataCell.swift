//
//  DataCell.swift
//  Dogecoin
//
//  Created by Sabyrzhan Tynybayev on 16.05.2021.
//

import UIKit

class DataCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var cellModel: DataCellModel? {
        didSet {
            nameLabel.text = cellModel?.name
            valueLabel.text = cellModel?.value
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


struct DataCellModel {
    let name: String
    let value: String
}
