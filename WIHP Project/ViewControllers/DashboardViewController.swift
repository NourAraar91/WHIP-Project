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
    
    // MARK:- IBOutlet
    @IBOutlet weak var tableView: DashBoardTableView! {
        didSet{
            let vm = DashBoardTableViewViewModel()
            tableView.viewModel = vm
        }
    }
    
    // MARK:- ViewModel
    var viewModel: DashboardViewControllerViewModel!
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind() 
    }
    
}

// MARK:- ViewModelBinldable
extension DashboardViewController {
    func bind() {
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
