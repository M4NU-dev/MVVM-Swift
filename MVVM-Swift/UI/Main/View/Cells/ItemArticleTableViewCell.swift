//
//  ItemArticleTableViewCell.swift
//  MVVM-Swift
//
//  Created by Luis Larrea on 8/1/21.
//

import UIKit

let secondsInAnHour: Double = 3600
let secondsInDays: Double = 86400
let secondsInWeek: Double = 604800

class ItemArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var txt_title: UILabel!
    @IBOutlet weak var txt_time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
