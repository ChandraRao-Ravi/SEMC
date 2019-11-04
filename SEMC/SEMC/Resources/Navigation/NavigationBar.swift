//
//  NavigationBar.swift
//  SEMC
//
//  Created by Chandra Rao on 21/10/19.
//  Copyright © 2018 Chandra Rao. All rights reserved.
//

import UIKit

class NavigationBar: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var buttonTitle: UIButton!

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var btnOptimumAI: UIButton!
    
    @IBOutlet weak var btnNotifications: UIButton!
    var hub = BadgeHub(view: UIView())
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("NavigationBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.bounds = self.bounds
        contentView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        contentView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
        
        self.hub = BadgeHub(view: self.btnNotifications) // Initially count set to 0
        self.hub.setCircleColor(UIColor(hexString: "#EC1ACC"), label: .white)
        self.hub.increment(by: 3)
        self.btnNotifications.addTarget(self, action: #selector(btnNotificationsClicked), for: .touchUpInside)
        
    }
    
    @objc func btnNotificationsClicked() {
        self.hub.increment()
    }
    
}
