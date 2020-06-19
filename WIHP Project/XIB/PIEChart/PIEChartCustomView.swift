//
//  PIEChartCustomView.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Charts

final class PIEChartCustomView: View {
    
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descritpionLabel: UILabel!
    
    // MARK:- ViewModel
    var viewModel: PIEChartCustomViewViewModel! {
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
        let view = Bundle.main.loadNibNamed("PIEChartCustomView", owner: self, options: nil)![0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(view)
        setup(pieChartView: chartView)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    func setup(pieChartView chartView: PieChartView) {
        
        let l = chartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        // entry label styling
        chartView.entryLabelColor = .white
        chartView.entryLabelFont = .systemFont(ofSize: 14, weight: .regular)
        
        chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
        
        chartView.usePercentValuesEnabled = true
        chartView.drawSlicesUnderHoleEnabled = false
        chartView.holeRadiusPercent = 0.4
        chartView.transparentCircleRadiusPercent = 0.5
        chartView.chartDescription?.enabled = false
        chartView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        
        chartView.drawHoleEnabled = true
        chartView.rotationAngle = 0
        chartView.rotationEnabled = true
        chartView.highlightPerTapEnabled = true

    }
        
    func setData(_ items: [ChartItem]) {
        let entries = (0..<items.count).map { (i) -> PieChartDataEntry in
            return PieChartDataEntry(value: items[i].value ?? 0.0,
                                     label: items[i].key,
                                     icon: nil)
        }
        
        let set = PieChartDataSet(entries: entries, label: "")
        set.sliceSpace = 2
        set.colors = ChartColorTemplates.material()
        
        let data = PieChartData(dataSet: set)
        
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueTextColor(.white)
        
        chartView.data = data
        chartView.highlightValues(nil)
    }

}

// MARK:- ViewModelBinldable
extension PIEChartCustomView {
    func bind() {
        self.titleLabel.text = viewModel.chartTitle.value
        self.descritpionLabel.text = viewModel.chartDescription.value
        let items = viewModel.chartItems.value
        setData(items)
    }
}
