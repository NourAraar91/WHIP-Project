//
//  DropDownViewViewModel.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/21/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DropDownViewViewModel: ViewModel {

    var selectedIndex: PublishSubject<Int>
    var actionButtonDidClicked = PublishSubject<Void>()
    var dataSource: [String]
    
    init( dataSource: [String]
        , selectedIndex: PublishSubject<Int>){
        self.dataSource = dataSource
        self.selectedIndex = selectedIndex
        super.init()
    }
}
