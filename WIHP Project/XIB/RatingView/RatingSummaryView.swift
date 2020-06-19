//
//  RatingSummaryView.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Charts

final class RatingSummaryView: View {
    
    @IBOutlet var chartView: HorizontalBarChartView!
    // MARK:- ViewModel
    var viewModel: RatingSummaryViewViewModel! {
        didSet {
            bind()
        }
    }
    
    // MARK:- Life cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
    }
    
    fileprivate func load() {
        let view = Bundle.main.loadNibNamed("RatingSummaryView", owner: self, options: nil)![0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
        setup()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    func setup() {
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
                
        chartView.drawBarShadowEnabled = false
        chartView.drawValueAboveBarEnabled = false
        
        let xAxis = chartView.xAxis
        xAxis.enabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .boldSystemFont(ofSize: 10)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.granularity = 10
        xAxis.valueFormatter = StarValueFormatter()
        
        chartView.fitBars = true
        chartView.legend.enabled = false
        
        chartView.animate(yAxisDuration: 2.5)
    }
    

    func setData(_ items: [String: Int]) {
        let barWidth = 7.0
        let spaceForBar = 10.0
        
        let yVals = (0..<items.count).map { (i) -> BarChartDataEntry in
            let val = items["\(i + 1)"] ?? 0
            return BarChartDataEntry(x: Double(i)*spaceForBar, y: Double(val), icon: nil)
        }
        
        let set1 = BarChartDataSet(entries: yVals, label: "DataSet")
        set1.setColor(.black)
        set1.drawValuesEnabled = false
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name:"HelveticaNeue-Light", size:10)!)
        data.barWidth = barWidth
        
        chartView.data = data
    }
    
}

// MARK:- ViewModelBinldable
extension RatingSummaryView {
    func bind() {
        setData(viewModel.items)
    }
}
