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
    var rating: Rating
    var ratingItems = BehaviorRelay<[String:Int]>(value: [:])
    var ratingAvg = BehaviorRelay<String>(value: "")
    var ratingCount = BehaviorRelay<String>(value: "")
    
    init(rating: Rating){
        self.rating = rating
        super.init()
        ratingItems.accept(rating.items)
        ratingAvg.accept("\(rating.avg)")
        let ratingCountValue = rating.items.values.reduce(0) { (resutl, x) -> Int in
            return resutl + x
        }
        ratingCount.accept("\(Double(ratingCountValue)) Ratings")
    }
}
