//
//  RatingSummaryViewViewModel.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class RatingSummaryViewViewModel: ViewModel {

    // MARK:- Dependency
    var items: [String: Int]
    init(items: [String: Int]){
        self.items = items
        super.init()
    }
}
