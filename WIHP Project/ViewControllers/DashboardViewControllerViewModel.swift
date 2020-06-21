//
//  DashboardViewControllerViewModel.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DashboardViewControllerViewModel: ViewModel {

    var filterTypeVarible =  BehaviorRelay<FilterType>(value: .all)
    var selectedIndex = PublishSubject<Int>()
    var filterTypes = FilterType.allCases
    var filterTypesDataSource: [String]
    override init(){
        filterTypesDataSource = filterTypes.map({$0.rawValue})
        super.init()
        
        selectedIndex
            .asObserver()
            .distinctUntilChanged()
            .subscribe(onNext: {[weak self] (index) in
                guard let strongSelf = self else { return }
                let selectedFilter = strongSelf.filterTypes[index]
                strongSelf.filterTypeVarible.accept(selectedFilter)
            }).disposed(by: disposeBag)
    }

}
