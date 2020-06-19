//
//  LineChartCustomViewViewModel.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class LineChartCustomViewViewModel: ViewModel {

    var chart: LineChart
    let chartTitle = BehaviorRelay<String>(value: "")
    let chartDescription = BehaviorRelay<String>(value: "")
    var chartItems = BehaviorRelay<[LineChartItem]>(value: [])

    init(chart: LineChart){
        self.chart = chart
        super.init()

        self.chartTitle.accept(chart.title ?? "")
        self.chartDescription.accept(chart.lineChartDescription ?? "")
        self.chartItems.accept(chart.items ?? [])
    }
}
