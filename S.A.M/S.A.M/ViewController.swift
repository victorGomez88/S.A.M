//
//  ViewController.swift
//  S.A.M
//
//  Created by Victor Gomez on 14/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ComicsService().getComicsList(inputModel: nil)
    }
}

