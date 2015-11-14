//
//  EventCell.swift
//  EventCreatorApp
//
//  Created by Henok WeldeMicael on 11/14/15.
//  Copyright © 2015 Henok WeldeMicael. All rights reserved.
//

import UIKit
import Parse

class EventCell: UITableViewCell {

    
    @IBOutlet var eventTitleLabel: UILabel! = UILabel()
    @IBOutlet var eventDescription: UILabel! = UILabel()
    @IBOutlet var foodButton: UIButton! = UIButton()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
