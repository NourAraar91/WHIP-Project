//
//  LineChartCustomView.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Charts

final class LineChartCustomView: View {
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descritpionLabel: UILabel!
    // MARK:- ViewModel
    var viewModel: LineChartCustomViewViewModel! {
        didSet {
            bind()
        }
    }
    // MARK:- Constant
    
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
        let view = Bundle.main.loadNibNamed("LineChartCustomView", owner: self, options: nil)![0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
        setup()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    func setup() {
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        chartView.highlightPerDragEnabled = true
        
        
        
        let l = chartView.legend
        l.form = .square
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.textColor = .black
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .topInside
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = false
        xAxis.granularity = 3600
        xAxis.valueFormatter = DateValueFormatter()
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelPosition = .insideChart
        leftAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        leftAxis.labelTextColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        
        
        chartView.rightAxis.enabled = false
        
        
        chartView.animate(xAxisDuration: 2.5)
    }
    
    
    func setData(_ items: [LineChartItem]) {
        
        let yVals1 = (0..<items.count).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: items[i].key.date?.timeIntervalSince1970 ?? 0.0, y: items[i].value[0].value)
        }
        let yVals2 = (0..<items.count).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: items[i].key.date?.timeIntervalSince1970 ?? 0.0, y: items[i].value[1].value)
        }
        
        
        let set1 = LineChartDataSet(entries: yVals1, label: "Jobs")
        set1.axisDependency = .left
        set1.setColor(ChartColorTemplates.material()[0])
        set1.setCircleColor(.red)
        set1.lineWidth = 2
        set1.circleRadius = 3
        set1.fillAlpha = 65/255
        set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let set2 = LineChartDataSet(entries: yVals2, label: "Services")
        set2.axisDependency = .right
        set2.setColor(ChartColorTemplates.material()[1])
        set2.setCircleColor(.blue)
        set2.lineWidth = 2
        set2.circleRadius = 3
        set2.fillAlpha = 65/255
        set2.fillColor = .red
        set2.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set2.drawCircleHoleEnabled = false
        
    
        let data = LineChartData(dataSets: [set1,set2])
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9))
        
        chartView.data = data
        
    }
    
}

// MARK:- ViewModelBinldable
extension LineChartCustomView {
    func bind() {
        self.titleLabel.text = viewModel.chartTitle.value
        self.descritpionLabel.text = viewModel.chartDescription.value
        let items = viewModel.chartItems.value
        setData(items)
    }
}
