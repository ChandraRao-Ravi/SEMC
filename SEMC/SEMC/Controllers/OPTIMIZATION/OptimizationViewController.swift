//
//  OptimizationViewController.swift
//  SEMC
//
//  Created by Chandra Rao on 21/10/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import UIKit

class OptimizationViewController: BaseViewController {

    @IBOutlet weak var glowView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
    }
}
