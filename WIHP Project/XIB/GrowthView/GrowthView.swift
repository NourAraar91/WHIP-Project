//
//  GrowthView.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class GrowthView: View {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descritpionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var growthLabel: UILabel!
    
    // MARK:- ViewModel
    var viewModel: GrowthViewViewModel! {
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
        let view = Bundle.main.loadNibNamed("GrowthView", owner: self, options: nil)![0] as! UIView
        view.frame = bounds
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
extension GrowthView {
    func bind() {
        titleLabel.text = viewModel.itemTitle.value
        descritpionLabel.text = viewModel.itemDescrition.value
        growthLabel.text = viewModel.growthPercent.value
        imageView.image = viewModel.image.value
    }
}
