//
//  GrowthViewViewModel.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class GrowthViewViewModel: ViewModel {

    var item: GrowthItem
    var itemTitle = BehaviorRelay<String>(value: "")
    var itemDescrition = BehaviorRelay<String>(value: "")
    var growthPercent = BehaviorRelay<String>(value: "")
    var image = BehaviorRelay<UIImage?>(value: nil)
    
    init(item: GrowthItem){
        self.item = item
        super.init()

        itemTitle.accept(item.title)
        itemDescrition.accept(item.itemDescription)
        growthPercent.accept("\(item.growth)%")
        if item.growth >= 0 {
            image.accept(UIImage(named:"up"))
        } else {
            image.accept(UIImage(named:"down"))
        }
    }
}
