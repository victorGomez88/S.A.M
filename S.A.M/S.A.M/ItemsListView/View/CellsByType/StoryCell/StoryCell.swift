//
//  StoryCell.swift
//  S.A.M
//
//  Created by Victor Gomez on 22/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit

class StoryCell: UITableViewCell {

    @IBOutlet weak var viewImageContainer: UIView!
    @IBOutlet weak var imgLeftImageView: UIImageView!
    
    @IBOutlet weak var lblTitleStory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
