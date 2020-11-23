//
//  ExternalLinksView.swift
//  S.A.M
//
//  Created by Victor Gomez on 18/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit

class ExternalLinksView: UIView {

    @IBOutlet private var contentView: UIView!
    
    //Left Link
    @IBOutlet private weak var leftExternalLinkContainer: UIView!
    @IBOutlet private weak var lblLeftExternalLink: UILabel!
    private var leftURLPath : String?
    
    //Separator
    @IBOutlet private weak var separatorContainer: UIView!
    
    //Right Link
    @IBOutlet private weak var rightExternalLinkContainer: UIView!
    @IBOutlet private weak var lblRightExternalLink: UILabel!
    private var rightURLPath : String?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        Bundle.main.loadNibNamed("ExternalLinksView", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        //All hidden until having values
        leftExternalLinkContainer.isHidden = true
        separatorContainer.isHidden = true
        rightExternalLinkContainer.isHidden = true
        
        //Set taps to links
        let tapLeft = UITapGestureRecognizer(target: self, action: #selector(leftUrlTapped))
        lblLeftExternalLink.addGestureRecognizer(tapLeft)
        lblLeftExternalLink.isUserInteractionEnabled = true
        
        let tapRight = UITapGestureRecognizer(target: self, action: #selector(rightUrlTapped))
        lblRightExternalLink.addGestureRecognizer(tapRight)
        lblRightExternalLink.isUserInteractionEnabled = true
    }
    
    func isComponenteHidden() -> Bool {
        return leftExternalLinkContainer.isHidden && separatorContainer.isHidden && rightExternalLinkContainer.isHidden
    }
    
    func setLeftLink(with nameLink: String, urlPath: String) {
    
        if !nameLink.isEmpty && !urlPath.isEmpty {
            leftExternalLinkContainer.isHidden = false
            separatorContainer.isHidden = rightExternalLinkContainer.isHidden
            lblLeftExternalLink.text = nameLink
            lblLeftExternalLink.isUserInteractionEnabled = true
            leftURLPath = urlPath
        }
        
    }
    
    func setRightLink(with nameLink: String, urlPath: String) {
    
        if !nameLink.isEmpty && !urlPath.isEmpty {
            rightExternalLinkContainer.isHidden = false
            separatorContainer.isHidden = leftExternalLinkContainer.isHidden
            lblRightExternalLink.text = nameLink
            lblRightExternalLink.isUserInteractionEnabled = true
            rightURLPath = urlPath
        }
    }
    
    @objc private func leftUrlTapped() {
        
        if let path = leftURLPath, let url = URL(string: path) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func rightUrlTapped() {
        if let path = rightURLPath, let url = URL(string: path) {
            UIApplication.shared.open(url)
        }
    }
}
