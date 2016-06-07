//
//  HeadlineTableViewCell.swift
//  StretchyHeader
//
//  Created by Taylor Benna on 2016-06-07.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
