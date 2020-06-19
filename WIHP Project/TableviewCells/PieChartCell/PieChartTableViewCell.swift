//
//  PieChartTableViewCell.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PieChartTableViewCell: UITableViewCell {
    @IBOutlet weak var chartView: PIEChartCustomView!
    
    var viewModel: PieChartTableViewCellViewModel! {
        didSet {
            bind()
        }
    }

}

extension PieChartTableViewCell {
    func bind() {
        let vm = PIEChartCustomViewViewModel(chart: viewModel.chart)
        chartView.viewModel = vm
    }
}
