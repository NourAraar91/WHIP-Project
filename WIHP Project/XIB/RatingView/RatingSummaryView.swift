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

final class RatingSummaryView: View {
    
    // MARK:- ViewModel
    var viewModel: RatingSummaryViewViewModel! {
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
        
    }

}

// MARK:- ViewModelBinldable
extension RatingSummaryView {
    func bind() {
    }
}
