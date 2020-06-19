//
//  Chart.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import Foundation


struct Chart {
    var title: String
    var type: String
    var description: String
    var items: [ChartItem]
}

struct ChartItem {
    var key: String
    var value: Double
}



struct LineChart {
    var title: String
    var type: String
    var description: String
    var items: [LineChartItem]
}

struct LineChartItem {
    var key: String
    var value: [ChartItem]
}


struct GrowthItem {
    var title: String
    var description: String
    var growth: Int
}
