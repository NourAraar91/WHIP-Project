//
//  DropDownView.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/21/20.
//Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class DropDownView: View {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    private let dropDown = DropDown()
    
    // MARK:- ViewModel
    var viewModel: DropDownViewViewModel! {
        didSet {
            bind()
            configureDropDown()
        }
    }
    
    @IBInspectable public var titleLabelfont: UIFont? {
        didSet {
            self.titleLabel.font = titleLabelfont
        }
    }
    
    @IBInspectable public var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue!
        }
    }
    
    @IBInspectable public var titleColor: UIColor? {
        didSet {
            self.titleLabel.textColor = titleColor
        }
    }
    
    @IBInspectable public var icon: UIImage? {
        didSet {
            self.iconImageView.image = icon
        }
    }
    
    // MARK:- Life cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        load()
        configureStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        load()
        configureStyle()
    }
    
    fileprivate func load() {
        let view = Bundle.main.loadNibNamed("DropDownView", owner: self, options: nil)![0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }
    
    private func configureStyle(){
        self.titleColor     = UIColor.black
        self.titleLabelfont = .systemFont(ofSize: 18)
    }

    @IBAction func actionButtonDidTapped(_ sender: UIButton) {
        self.viewModel.actionButtonDidClicked.onNext(())
    }
    
    func selecteAt(index:Int) {

    }
    
    private func configureDropDown(){
        dropDown.anchorView = self
        dropDown.dataSource = viewModel.dataSource
        dropDown.configureDesing()
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.title = item
            self.viewModel.selectedIndex.onNext(index)
        }
    }
    
}

// MARK:- ViewModelBinldable
extension DropDownView {
    func bind() {
        
        viewModel
            .actionButtonDidClicked
            .asObserver()
            .subscribe(onNext: {[weak self] (_) in
                guard let strongSelf = self else { return }
                if strongSelf.dropDown.isHidden{
                    strongSelf.dropDown.show()
                }else{
                    strongSelf.dropDown.hide()
                }
            }).disposed(by: disposeBag)
    }
}
