//
//  BaseViewController.swift
//  SEMC
//
//  Created by Chandra Rao on 21/10/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import UIKit

public enum Theme: Int {
    case dark = 0
    case light
}

class BaseViewController: UIViewController {
    
    var currentLayer: CAGradientLayer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setGradientBackground(withTheme: .dark)
        super.viewWillAppear(animated)
    }
    
    func setGradientBackground(withTheme theme: Theme) {
        var colors: [Any]? = nil
        
        switch theme {
        case .dark:
            colors = [
                UIColor(red: 13.0/255.0, green: 0.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 23.0/255.0, green: 10.0/255.0, blue: 82.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 35.0/255.0, green: 16.0/255.0, blue: 108.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 77.0/255.0, green: 20.0/255.0, blue: 123.0/255.0, alpha: 1.0).cgColor
            ]
        case .light:
            colors = [
                UIColor(red: 1.0/255.0, green: 18.0/255.0, blue: 133.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 15.0/255.0, green: 33.0/255.0, blue: 133.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 18.0/255.0, green: 31.0/255.0, blue: 129.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 29.0/255.0, green: 49.0/255.0, blue: 156.0/255.0, alpha: 1.0).cgColor
            ]
        }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.25, 0.50, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.currentLayer = gradientLayer
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func replaceViewlayers(withTheme theme: Theme) {
        var colors: [Any]? = nil
        
        switch theme {
        case .dark:
            colors = [
                UIColor(red: 13.0/255.0, green: 0.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 23.0/255.0, green: 10.0/255.0, blue: 82.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 35.0/255.0, green: 16.0/255.0, blue: 108.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 77.0/255.0, green: 20.0/255.0, blue: 123.0/255.0, alpha: 1.0).cgColor
            ]
        case .light:
            colors = [
                UIColor(red: 1.0/255.0, green: 18.0/255.0, blue: 133.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 15.0/255.0, green: 33.0/255.0, blue: 133.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 18.0/255.0, green: 31.0/255.0, blue: 129.0/255.0, alpha: 1.0).cgColor,
                UIColor(red: 29.0/255.0, green: 49.0/255.0, blue: 156.0/255.0, alpha: 1.0).cgColor
            ]
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = [0.0, 0.25, 0.50, 1.0]
        gradientLayer.frame = self.view.bounds
        
        if let layer = self.currentLayer {
            self.currentLayer = gradientLayer
            self.view.layer.replaceSublayer(layer, with: gradientLayer)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
