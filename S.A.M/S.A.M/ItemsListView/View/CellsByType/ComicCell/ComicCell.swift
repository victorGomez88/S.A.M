//
//  ComicCell.swift
//  S.A.M
//
//  Created by Victor Gomez on 19/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit

class ComicCell: UITableViewCell {

    
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var lblComicName: UILabel!
    @IBOutlet weak var lblComicFormat: UILabel!
    @IBOutlet weak var lblIssueNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
