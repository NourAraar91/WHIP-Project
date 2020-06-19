//
//  Created by Nour Araar on 6/19/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//  See LICENSE.txt for license information
//

import Foundation
import RxSwift
import RxCocoa

class TitleTableViewCellViewModel: ViewModel {
    
    var title: String
    var subtitle: String

    
    init(title: String,
         subtitle: String){
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
}
