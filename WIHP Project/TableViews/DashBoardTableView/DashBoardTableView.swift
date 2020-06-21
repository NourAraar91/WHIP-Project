//
//  DashBoardTableView.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class DashBoardTableView: UITableView {
    
    let disposeBag = DisposeBag()
    
    let refreshController = UIRefreshControl()
    
    var viewModel: DashBoardTableViewViewModel! {
        didSet {
            // set delegate if need
            delegate = viewModel
            bind()
        }
    }
    
    override func updateConstraints() {
        setup()
        setupRefreshControl()
        super.updateConstraints()
    }
    
    func setup(){
        let cells = [ PieChartTableViewCell.self
                    , LineChartTableViewCell.self
                    , JobTableViewCell.self
                    , TitleTableViewCell.self
                    , RateTableViewCell.self ]
        registerCells(cells: cells)
        rowHeight =  UITableViewAutomaticDimension
        keyboardDismissMode = .onDrag
    }
    
    func setupRefreshControl() {
        refreshController.rx
            .controlEvent(UIControlEvents.valueChanged)
            .subscribe(onNext: {[weak self] (_) in
            self?.refresh()
            self?.refreshController.endRefreshing()
            }).disposed(by: disposeBag)
            
        if #available(iOS 10.0, *) {
            self.refreshControl = refreshController
        } else {
            addSubview(refreshController)
        }
    }
}

// MARK:- ViewModelBinldable
extension DashBoardTableView {
    func bind() {
       viewModel
            .sectionsModels
            .asObservable()
            .bind(to: self.rx.items(dataSource: viewModel.skinTableViewDataSource()))
            .disposed(by: disposeBag)
    }
}

extension DashBoardTableView {
    func refresh() {
        if (self.viewModel != nil ){
            self.viewModel.refresh()
        }
    }
}
