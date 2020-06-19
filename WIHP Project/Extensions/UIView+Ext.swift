//
//  UIView+Ext.swift
//  WIHP Project
//
//  Created by Nour Araar on 6/19/20.
//  Copyright © 2020 Nour Araar. All rights reserved.
//

import UIKit

extension UIView {
    
    /// set corner radius from interface builder
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    /// set border width from interface builder
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var shadowWithCornerRadius: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadowWithCornerRadius()
            }
        }
    }
    
  
    
    @IBInspectable public var shadowColor: UIColor? {
        get {
            return UIColor(cgColor:layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
 
    @IBInspectable public var shadowOffsetX: CGFloat {
        get {
            return layer.shadowOffset.width
        }
        set {
            layer.shadowOffset = CGSize(width: newValue, height: shadowOffsetY)
        }
    }
    
    @IBInspectable public var shadowOffsetY: CGFloat {
        get {
            return layer.shadowOffset.height
            
        }
        set {
             layer.shadowOffset = CGSize(width: shadowOffsetX, height: newValue)
        }
    }

    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
            
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable public var shadowBlur: CGFloat {
        get {
            return layer.shadowRadius * 2
            
        }
        set {
            layer.shadowRadius = newValue / 2
        }
    }
    
    @IBInspectable public var shadowSpread: CGFloat {
        get {
            return layer.shadowPath?.boundingBox.width ?? 0
        }
        set {
            if newValue == 0 {
                layer.shadowPath = nil
            } else {
                let dx = -newValue
                let rect = bounds.insetBy(dx: dx, dy: dx)
               layer.shadowPath = UIBezierPath(rect: rect).cgPath
            }
        }
    }

    @IBInspectable public var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            
            layer.borderColor = newValue?.cgColor
        }
    }
    
    
    
    func addShadow(shadowColor: CGColor = UIColor.black.withAlphaComponent(0.2).cgColor,
                   shadowOffset: CGSize = CGSize(width: 0, height: 0),
                   shadowOpacity: Float = 1.0,
                   shadowRadius: CGFloat = 5.0) {
        clipsToBounds = false
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    
    func addShadowWithCornerRadius(){
        self.layer.cornerRadius = cornerRadius
        let shadowPath2 = UIBezierPath(rect: self.bounds)
        self.layer.masksToBounds = false
        addShadow()
        self.layer.shadowPath = shadowPath2.cgPath
    }
    
}
