//
//  DashboardViewModel.swift
//  S.A.M
//
//  Created by Victor Gomez on 16/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class DashboardViewModel {
    private weak var view: DashboardViewController?
    private var router: DashboardRouter?
    
    func bind(view: DashboardViewController, router: DashboardRouter) {
        self.view = view
        self.router = router
        self.router?.setDashboardView(view)
    }
}
