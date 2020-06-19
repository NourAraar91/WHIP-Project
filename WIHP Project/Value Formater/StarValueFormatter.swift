//
//  StarValueFormatter.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import Foundation
import Charts

public class StarValueFormatter: NSObject, IAxisValueFormatter {
    private let starArray = ["★","★★","★★★","★★★★","★★★★★"]
    
    override init() {
        super.init()
        
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return starArray[Int(value / 10)]
    }
}
