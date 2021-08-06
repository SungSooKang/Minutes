//
//  MinutesTableViewCell.swift
//  minutes
//
//  Created by 강성수 on 2021/07/27.
//

import UIKit

class MinutesTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dialogue: UITextView!
    @IBOutlet weak var atTime: UILabel!
    
    @IBOutlet weak var dialogue2: UITextView!
    @IBOutlet weak var name2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
