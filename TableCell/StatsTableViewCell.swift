//
//  StatsTableViewCell.swift
//  minutes
//
//  Created by 강성수 on 2021/07/29.
//

import UIKit

class StatsTableViewCell: UITableViewCell {

    @IBOutlet weak var numberStats: UILabel!
    @IBOutlet weak var nameStats: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
