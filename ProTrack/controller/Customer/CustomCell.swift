//
//  CustomCell.swift
//  ProTrack
//
//  Created by Sunny on 26/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var reqId: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
