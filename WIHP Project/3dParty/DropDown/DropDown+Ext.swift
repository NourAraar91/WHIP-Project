//
//  DropDown+Ext.swift
//  
//
//  Created by Nour Araar on 6/21/20.
//  Copyright © 2019 Fave. All rights reserved.
//

import UIKit

extension DropDown {
    func configureDesing(){
        self.direction = .bottom
        self.dismissMode = .automatic
        self.cellHeight = 50
        self.backgroundColor = .white
        self.selectionBackgroundColor = UIColor.gray
        self.textFont = .systemFont(ofSize: 18)
        self.textColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        self.separatorColor = UIColor.separator
        self.dropDownCornerRadius = 5
        self.dropDownShadowColor = UIColor(white: 0.2, alpha: 0.1)
        self.borderWidth = 1
        self.borderColorX = UIColor.separator
        guard let anchorView = anchorView else {return}
        self.bottomOffset = CGPoint(x: 0, y:(anchorView.plainView.bounds.height + 2))
    }
}
