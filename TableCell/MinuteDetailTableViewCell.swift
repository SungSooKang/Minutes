//
//  MinuteDetailTableViewCell.swift
//  minutes
//
//  Created by 강성수 on 2021/07/29.
//

import UIKit

class MinuteDetailTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailDialogue: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
