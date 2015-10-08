//
//  ManagerCustomCell.swift
//  ProTrack
//
//  Created by Sunny on 08/10/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit

class ManagerCustomCell: UITableViewCell {
    @IBOutlet weak var reqLabel: UILabel!
    @IBOutlet weak var priorityImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
