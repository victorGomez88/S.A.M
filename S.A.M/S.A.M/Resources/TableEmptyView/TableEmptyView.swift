//
//  TableEmptyView.swift
//  S.A.M
//
//  Created by Victor Gomez on 18/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit

class TableEmptyView: UIView {

    @IBOutlet weak var emptyImage: UIImageView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    func customInit() {
        super.awakeFromNib()
        Bundle.main.loadNibNamed("TableEmptyView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        guard let image = UIImage(named:"emptyResults") else { return }
        emptyImage.image = image
    }
    
    func setEmptyMessage(message: String) {
        emptyLabel.text = message
    }
    

}
