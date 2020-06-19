//
//  LineChartTableViewCell.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LineChartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chartView: LineChartCustomView!
    var viewModel: LineChartTableViewCellViewModel! {
        didSet {
            bind()
        }
    }

}

extension LineChartTableViewCell {
    func bind() {
        let vm = LineChartCustomViewViewModel(chart: viewModel.chart)
        chartView.viewModel = vm
    }
}
