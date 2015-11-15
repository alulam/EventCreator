//
//  SingleCell.swift
//  EventCreatorApp
//
//  Created by Henok WeldeMicael on 11/14/15.
//  Copyright © 2015 Henok WeldeMicael. All rights reserved.
//

import UIKit

class SingleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel! = UILabel()
    
    @IBOutlet weak var descLabel: UILabel! = UILabel()
    
    @IBOutlet weak var foodButton: UIButton! = UIButton()
    
    @IBOutlet weak var dateLabel: UILabel! = UILabel()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
