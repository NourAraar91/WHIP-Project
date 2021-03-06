//
//  DashBoardTableViewViewModel.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


enum FilterType: String ,  CaseIterable {
    case all = "ALL"
    case today = "TODAY"
    case last7Days = "LAST 7 DAYS"
    case last30Days = "LAST 30 DAYS"
    
    var value: String {
        switch self {
        case .all:
            return "ALL"
        case .today:
            return "TODAY"
        case .last7Days:
            return "LAST_7_DAYS"
        case .last30Days:
            return "LAST_30_DAYS"
            
        }
    }
}

final class DashBoardTableViewViewModel: ViewModel {
    
    
    // MARK:- Output
    var sectionsModels: BehaviorRelay<[DashBoardTableViewViewModelSectionModel]> = BehaviorRelay<[DashBoardTableViewViewModelSectionModel]>(value: [])
    var tableViewDataSource: RxTableViewSectionedReloadDataSource<DashBoardTableViewViewModelSectionModel>?
    var sections = [DashBoardTableViewViewModelSectionModel]()
    var responseObserver = BehaviorSubject<ResponseAPIResponse?>(value: nil)
    var api = ResponseAPI()
    var filterTypeVarible: BehaviorRelay<FilterType>
    
    init(filterTypeVarible: BehaviorRelay<FilterType>){
        self.filterTypeVarible = filterTypeVarible
        super.init()
        
        filterTypeVarible
            .asObservable()
            .subscribe(onNext: { [weak self] (value) in
                guard let strongSelf = self else { return }
                strongSelf.requestData(filterType: value)
            }).disposed(by: disposeBag)
        
        
        responseObserver
            .asObserver()
            .subscribe(onNext: { [weak self](response) in
                guard let strongSelf = self else { return }
                guard let response = response?.response else { return }
                strongSelf.sections.removeAll()
                
                if let rating = response.data.analytics.rating {
                    let rateTitleViewModle = TitleTableViewCellViewModel(title: rating.title , subtitle: rating.ratingDescription)
                    let rateTitleItem = DashBoardTableViewViewModelSectionItem.title(viewModel: rateTitleViewModle)
                    strongSelf.sections.append(DashBoardTableViewViewModelSectionModel.section(items: [rateTitleItem]))
                    
                    let rateViewModle = RateTableViewCellViewModel(rating: rating)
                    let rateItem = DashBoardTableViewViewModelSectionItem.rate(viewModel: rateViewModle)
                    strongSelf.sections.append(DashBoardTableViewViewModelSectionModel.section(items: [rateItem]))
                }
                
                if let job = response.data.analytics.job {
                    let jobTitleViewModle = TitleTableViewCellViewModel(title: job.title, subtitle: job.jobDescription)
                    let jobTitleItem = DashBoardTableViewViewModelSectionItem.title(viewModel: jobTitleViewModle)
                    strongSelf.sections.append(DashBoardTableViewViewModelSectionModel.section(items: [jobTitleItem]))
                    
                    var jobsItemsList = [DashBoardTableViewViewModelSectionItem]()
                    for job in job.items {
                        let cellViewModel = JobTableViewCellViewModel(growthItem: job)
                        let jobsItem = DashBoardTableViewViewModelSectionItem.job(viewModel: cellViewModel)
                        jobsItemsList.append(jobsItem)
                        
                    }
                    strongSelf.sections.append(DashBoardTableViewViewModelSectionModel.section(items: jobsItemsList))
                }
                
            
                if let services = response.data.analytics.service {
                    let servicesTitleViewModle = TitleTableViewCellViewModel(title: services.title, subtitle: services.jobDescription)
                    let servicesTitleItem = DashBoardTableViewViewModelSectionItem.title(viewModel: servicesTitleViewModle)
                    strongSelf.sections.append(DashBoardTableViewViewModelSectionModel.section(items: [servicesTitleItem]))
                        
                    var servicesItemsList = [DashBoardTableViewViewModelSectionItem]()
                    for service in services.items {
                        let cellViewModel = JobTableViewCellViewModel(growthItem: service)
                        let serviceItem = DashBoardTableViewViewModelSectionItem.job(viewModel: cellViewModel)
                        servicesItemsList.append(serviceItem)
                        
                    }
                    strongSelf.sections.append(DashBoardTableViewViewModelSectionModel.section(items: servicesItemsList))
                }
                
                if let linecharts = response.data.analytics.lineCharts {
                    var lineChartItemsList = [DashBoardTableViewViewModelSectionItem]()
                    for chart in linecharts.first ?? [] {
                        let cellViewModel = LineChartTableViewCellViewModel(chart: chart)
                        let lineItem = DashBoardTableViewViewModelSectionItem.lineChart(viewModel: cellViewModel)
                        lineChartItemsList.append(lineItem)
                    }
                    strongSelf.sections.append(DashBoardTableViewViewModelSectionModel.section(items: lineChartItemsList))
                }
                
                if let piecharts = response.data.analytics.pieCharts{
                    var pieChartItemsList = [DashBoardTableViewViewModelSectionItem]()
                    for chart in piecharts {
                        let cellViewModel = PieChartTableViewCellViewModel(chart: chart)
                        let pieItem = DashBoardTableViewViewModelSectionItem.pieChart(viewModel: cellViewModel)
                        pieChartItemsList.append(pieItem)
                        
                    }
                    strongSelf.sections.append(DashBoardTableViewViewModelSectionModel.section(items: pieChartItemsList))
                }
                
                strongSelf.sectionsModels.accept(strongSelf.sections)
            }).disposed(by: disposeBag)
    }
    
    func skinTableViewDataSource() -> RxTableViewSectionedReloadDataSource<DashBoardTableViewViewModelSectionModel>{
        return RxTableViewSectionedReloadDataSource<DashBoardTableViewViewModelSectionModel>(
            configureCell : { (dataSource , tableView, indexPath, item) in
                self.tableViewDataSource = dataSource as? RxTableViewSectionedReloadDataSource<DashBoardTableViewViewModelSectionModel>
                switch item {
                case .pieChart(viewModel: let viewModel):
                    let cell: PieChartTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                    cell.viewModel = viewModel
                    cell.layoutIfNeeded()
                    cell.layoutSubviews()
                    return cell
                    
                case .lineChart(viewModel: let viewModel):
                    let cell: LineChartTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                    cell.viewModel = viewModel
                    cell.layoutIfNeeded()
                    cell.layoutSubviews()
                    return cell
                case .job(viewModel: let viewModel):
                    let cell: JobTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                    cell.viewModel = viewModel
                    cell.layoutIfNeeded()
                    cell.layoutSubviews()
                    return cell
                case .title(viewModel: let viewModel):
                    let cell: TitleTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                    cell.viewModel = viewModel
                    cell.layoutIfNeeded()
                    cell.layoutSubviews()
                    return cell
                case .rate(viewModel: let viewModel):
                    let cell: RateTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                    cell.viewModel = viewModel
                    cell.layoutIfNeeded()
                    cell.layoutSubviews()
                    return cell
                }
        })
    }
}

extension DashBoardTableViewViewModel {
    func refresh() {
        requestData(filterType: filterTypeVarible.value)
    }
}

extension DashBoardTableViewViewModel {
    fileprivate func requestData(filterType: FilterType) {
        api.request(scope: filterType.value,
                    completionHandler: {[weak self] (response) in
                        guard let strongSelf = self else { return }
                        strongSelf.responseObserver.onNext(response)
        }) { (error) in
            print(error)
        }
    }
}

enum DashBoardTableViewViewModelSectionModel {
    case section(items: [DashBoardTableViewViewModelSectionItem])
}


enum DashBoardTableViewViewModelSectionItem {
    case pieChart(viewModel: PieChartTableViewCellViewModel)
    case lineChart(viewModel: LineChartTableViewCellViewModel)
    case job(viewModel: JobTableViewCellViewModel)
    case title(viewModel: TitleTableViewCellViewModel)
    case rate(viewModel: RateTableViewCellViewModel)
    
    var identity: String {
        switch self {
        case .pieChart(viewModel: let viewModel): return viewModel.UUID
        case .lineChart(viewModel: let viewModel): return viewModel.UUID
        case .job(viewModel: let viewModel): return viewModel.UUID
        case .title(viewModel: let viewModel): return viewModel.UUID
        case .rate(viewModel: let viewModel): return viewModel.UUID
        }
    }
}

extension DashBoardTableViewViewModelSectionModel: SectionModelType {
    typealias Item = DashBoardTableViewViewModelSectionItem
    
    var items: [DashBoardTableViewViewModelSectionItem] {
        switch  self {
        case .section(items: let items):
            return items
        }
    }
    
    init(original: DashBoardTableViewViewModelSectionModel, items: [Item]) {
        switch original {
        case .section(items: _):
            self = .section(items: items)
        }
    }
}

extension DashBoardTableViewViewModel: UITableViewDelegate {
    
    // Load Next if need
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let numberOfSection = tableView.numberOfSections
        let currentSection = indexPath.section
        guard numberOfSection >= 10 else { return }
        if currentSection > (numberOfSection - 10) {
            // TODO: Call Load Next Function here
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = tableViewDataSource?[indexPath] else { return 0.0 }
        switch item {
        case .pieChart(viewModel: _):
            return 450
        case .lineChart(viewModel: _):
            return 450
        case .job(viewModel: _):
            return 100
        case .title(viewModel: _):
            return 76
        case .rate(viewModel: _):
            return 132
        }
    }
}

