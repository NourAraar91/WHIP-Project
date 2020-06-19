//
//  JobTableViewCell.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class JobTableViewCell: UITableViewCell {
    
    @IBOutlet weak var growthView: GrowthView!
    
    var viewModel: JobTableViewCellViewModel! {
        didSet {
            bind()
        }
    }
    
}

extension JobTableViewCell {
    func bind() {
        let vm = GrowthViewViewModel(item: viewModel.growthItem)
        growthView.viewModel = vm
    }
}
