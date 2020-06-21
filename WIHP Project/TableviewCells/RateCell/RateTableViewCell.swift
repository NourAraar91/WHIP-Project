//
//  RateTableViewCell.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class RateTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rateView: RatingSummaryView!
    
    var viewModel: RateTableViewCellViewModel! {
        didSet {
            bind()
        }
    }
}

extension RateTableViewCell {
    func bind() {
        rateView.viewModel = RatingSummaryViewViewModel(rating: viewModel.rating)
    }
}
