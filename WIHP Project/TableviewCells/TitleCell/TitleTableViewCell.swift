//
//  TitleTableViewCell.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: TitleTableViewCellViewModel! {
        didSet {
            bind()
        }
    }

}

extension TitleTableViewCell {
    func bind() {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.subtitle
    }
}
