//
//  Created by Nour Araar on 6/19/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//  See LICENSE.txt for license information
//

import Foundation
import RxSwift
import RxCocoa

class PieChartTableViewCellViewModel: ViewModel {
    
    var chart: PieChart
    
    
    init(chart: PieChart){
        self.chart = chart
        super.init()
    }
}
