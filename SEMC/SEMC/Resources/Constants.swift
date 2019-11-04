//
//  Constants.swift
//  SEMC
//
//  Created by Chandra Rao on 21/10/19.
//  Copyright © 2017 Chandra Rao. All rights reserved.
//

import Foundation
import UIKit

class Constants {
    static let BackButtonImageName = "backButton"
    static let AppName = "SEMC"
}

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

extension UIView {
    func makeBorderGlow(withColor colorString: String) -> Timer {
        self.layer.shadowColor = UIColor(hexString: colorString).cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        self.layer.borderColor = UIColor(hexString: colorString).cgColor
        self.layer.borderWidth = 5.0
        
        self.layer.masksToBounds = false
        
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.0
        self.layer.cornerRadius = 142.0
        
        var i = 0
        var status = true
        
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            self.layer.shadowOpacity = Float(i) * 0.1
            if status {
                i += 1
                if i == 10 {
                    status = false
                }
            } else {
                i -= 1
                if i == 0 {
                    status = true
                }
            }
            
        }
        return timer
    }
}
