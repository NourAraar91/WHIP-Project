//
//  DashboardViewController.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DashboardViewController: UIViewController {
    
    @IBOutlet weak var filterDropDown: DropDownView! {
        didSet {
            let dropDownViewModel = DropDownViewViewModel(dataSource: viewModel.filterTypesDataSource, selectedIndex: viewModel.selectedIndex)
            filterDropDown.viewModel = dropDownViewModel
            filterDropDown.selecteAt(index: 0)
        }
    }
    // MARK:- IBOutlet
    @IBOutlet weak var tableView: DashBoardTableView!
    
    // MARK:- ViewModel
    var viewModel: DashboardViewControllerViewModel!
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        makeNavBarTranslucent()
    }
    
    func makeNavBarTranslucent() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
    }
}

// MARK:- ViewModelBinldable
extension DashboardViewController {
    func bind() {
        let tableViewViewModel = DashBoardTableViewViewModel(filterTypeVarible: viewModel.filterTypeVarible)
        tableView.viewModel = tableViewViewModel
        

    }
}

// MARK:- Buildable
extension DashboardViewController {
    class func build(_ builder: DashboardViewControllerViewModel) -> DashboardViewController {
        let storyboard = UIStoryboard(name: "DashboardViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        vc.viewModel = builder
        return vc
    }
}
