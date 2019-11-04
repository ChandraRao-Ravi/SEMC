//
//  GraphCollectionViewCell.swift
//  SEMC
//
//  Created by Chandra Rao on 05/11/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import UIKit

class GraphCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewBar: UIView!
    @IBOutlet weak var viewBarTopConstant: NSLayoutConstraint!

    func setBarConstant() {
        var upperBound = Int(self.frame.size.height)
        if upperBound + 100 > upperBound {
            upperBound -= 100
        }
        let randomNumber = Int.random(in: 10 ... upperBound)
        self.viewBarTopConstant.constant = CGFloat(randomNumber)
    }
}
