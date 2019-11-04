//
//  DashboardViewController.swift
//  SEMC
//
//  Created by Chandra Rao on 21/10/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import UIKit
import HMSegmentedControl

protocol DataDelegate: NSObject {
    func invalidateTimer()
}
class DashboardViewController: BaseViewController {
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var barChart: UICollectionView!
    
    @IBOutlet weak var viewHMSegment: UIView!

    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    weak var delegate: DataDelegate? = nil
    
    var currentRowIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setUpNavigationBar()
        setUpUI()
        setUpOptimumAiButton()
        configureHMSegment(withSectionArray: [
            "Realtime",
            "Appliance Usage",
            "Savings",
            "Energy Produced/ Consumed"
            ])
    }
    
    func setUpNavigationBar() {
        self.navigationBar.buttonTitle.setTitle(String(format: "25 %@C", "\u{00B0}"), for: .normal)
    }
    
    func generateRandomNumber(withLowerBound lowerBound: Int, withHigerBound higherBound: Int) -> Int {
        let randomNumber = Int.random(in: lowerBound ... higherBound)
        //        print("Random Number \(randomNumber)")
        return randomNumber
    }
    
    func setUpUI() {
        self.leftButton.layer.cornerRadius = 25
        self.leftButton.layer.borderColor = UIColor.white.cgColor
        self.leftButton.layer.borderWidth = 1.0
        self.leftButton.layer.masksToBounds = true
        
        self.rightButton.layer.cornerRadius = 25
        self.rightButton.layer.borderColor = UIColor.white.cgColor
        self.rightButton.layer.borderWidth = 1.0
        self.rightButton.layer.masksToBounds = true
    }
    
    @IBAction func leftButtonClicked(_ sender: Any) {
        var randomNumber = Int.random(in: 0 ... 1000)
        while randomNumber > currentRowIndex {
            randomNumber = Int.random(in: 0 ... 1000)
        }
        currentRowIndex = randomNumber
        self.barChart.scrollToItem(at: IndexPath(row: randomNumber, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
    }
    
    @IBAction func rightButtonClicked(_ sender: Any) {
        var randomNumber = Int.random(in: 0 ... 1000)
        while randomNumber < currentRowIndex {
            randomNumber = Int.random(in: 0 ... 1000)
        }
        currentRowIndex = randomNumber
        self.barChart.scrollToItem(at: IndexPath(row: randomNumber, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
    }
    
    func setUpOptimumAiButton() {
        self.navigationBar.btnOptimumAI.addTarget(self, action: #selector(btnOptimumAIClicked), for: .touchUpInside)
        self.navigationBar.btnOptimumAI.layer.masksToBounds = true
        self.navigationBar.btnOptimumAI.layer.borderWidth = 1.0
        self.navigationBar.btnOptimumAI.layer.cornerRadius = 12.5
        self.navigationBar.btnOptimumAI.layer.borderColor = UIColor(hexString: "#0ADFEF").cgColor
        self.customiseButtonOnState()
    }
    
    func customiseButtonOnState() {
        self.navigationBar.btnOptimumAI.isSelected = true
        self.navigationBar.btnOptimumAI.layer.borderColor = UIColor(hexString: "#0ADFEF").cgColor
        
        let onOffText = NSString(string: "ON  ●")
        
        let onOffStateAttributedText = NSMutableAttributedString.init(string: onOffText as? String ?? "")
        
        if let bulletRange = onOffText.range(of: "●") as? NSRange {
            onOffStateAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Medium", size: 16.0) ?? UIFont.systemFont(ofSize: 17),
                                                    NSAttributedString.Key.foregroundColor: UIColor(hexString: "#0ADFEF")],
                                                   range: bulletRange)
        }
        if let textRange = onOffText.range(of: "ON") as? NSRange {
            onOffStateAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Medium", size: 15.0) ?? UIFont.systemFont(ofSize: 17),
                                                    NSAttributedString.Key.foregroundColor: UIColor.white],
                                                   range: textRange)
        }
        self.navigationBar.btnOptimumAI.setAttributedTitle(onOffStateAttributedText, for: .normal)
    }
    
    func customiseButtonOffState() {
        self.navigationBar.btnOptimumAI.isSelected = false
        self.navigationBar.btnOptimumAI.layer.borderColor = UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.6).cgColor
        
        let onOffText = NSString(string: "● OFF")
        let onOffStateAttributedText = NSMutableAttributedString.init(string: onOffText as? String ?? "")
        
        if let bulletRange = onOffText.range(of: "●") as? NSRange {
            onOffStateAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Medium", size: 16.0) ?? UIFont.systemFont(ofSize: 17),
                                                    NSAttributedString.Key.foregroundColor: UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.6)],
                                                   range: bulletRange)
        }
        if let textRange = onOffText.range(of: "OFF") as? NSRange {
            onOffStateAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Medium", size: 15.0) ?? UIFont.systemFont(ofSize: 17),
                                                    NSAttributedString.Key.foregroundColor: UIColor(red: 255.0, green: 255.0, blue: 255.0, alpha: 0.6)],
                                                   range: textRange)
        }
        self.navigationBar.btnOptimumAI.setAttributedTitle(onOffStateAttributedText, for: .normal)
    }
    
    @objc func btnOptimumAIClicked() {
        if self.navigationBar.btnOptimumAI.isSelected {
            self.customiseButtonOffState()
            self.replaceViewlayers(withTheme: .light)
        } else {
            self.customiseButtonOnState()
            self.replaceViewlayers(withTheme: .dark)
        }
    }
    
    func configureHMSegment(withSectionArray array:[String]?) {
        if let arrData = array {
            let hmSegment: HMSegmentedControl = HMSegmentedControl(sectionTitles: arrData)
            hmSegment.frame = CGRect(x: 0, y: 0, width: self.viewHMSegment.frame.size.width, height: self.viewHMSegment.frame.size.height)
            hmSegment.autoresizingMask = .flexibleWidth
            hmSegment.backgroundColor = UIColor(hexString: "#371F78")
            hmSegment.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            hmSegment.selectionIndicatorColor = UIColor(hexString: "#0ADFEF")
            hmSegment.selectionIndicatorLocation = .down
            hmSegment.borderType = .bottom
            hmSegment.segmentWidthStyle = .fixed
            hmSegment.addTarget(self, action: #selector(hmSegmentValueChanged(_:)), for: .valueChanged)
            self.viewHMSegment.addSubview(hmSegment)
            
            self.viewHMSegment.layer.masksToBounds = true
            self.viewHMSegment.layer.borderWidth = 1.0
            self.viewHMSegment.layer.borderColor = UIColor.clear.cgColor
            self.viewHMSegment.layer.cornerRadius = 20.0
        }
    }
    
    @objc func hmSegmentValueChanged(_ segmentControl: HMSegmentedControl) {
        print("Selected Index: \(segmentControl.selectedSegmentIndex)")
    }
}

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return 4
        } else if collectionView == self.barChart {
            return 1000
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            if let collectionCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: indexPath) as? DashboardCollectionViewCell {
                collectionCell.dataSource = self
                if indexPath.row == 0 {
                    collectionCell.customizeTextForDevices()
                } else if  indexPath.row == 1 {
                    collectionCell.customizeTextForEconomy()
                } else if indexPath.row == 2 {
                    collectionCell.customizeTextForRank()
                } else if indexPath.row == 3 {
                    collectionCell.customizeTextForSavings()
                }
                collectionCell.customiseTitleLabel(withValues: 1.0)
                self.delegate = collectionCell
                return collectionCell
            }
        } else if collectionView == self.barChart {
            if let collectionCell = self.barChart.dequeueReusableCell(withReuseIdentifier: "GraphCollectionViewCell", for: indexPath) as? GraphCollectionViewCell {
                collectionCell.setBarConstant()
                return collectionCell
            }
        }
        return UICollectionViewCell()
    }
}

extension DashboardViewController: SEMCDataSource {
    func getEnergyUnitsInkWh() -> Int? {
        let energy = self.generateRandomNumber(withLowerBound: 820, withHigerBound: 850)
        return energy
    }
    
    func getNumberOfDevices() -> String? {
        return "28"
    }
    
    func getEnergyEconomy() -> String? {
        return "Super Economy"
    }
    
    func getRank() -> String? {
        return "3"
    }
    
    func getRankSuperScript() -> String? {
        return "rd"
    }
    
    func getNeighbours() -> String? {
        return "10"
    }
    
    func getMonthlySavings() -> String? {
        return "356"
    }
    
    func getSavingsCurrency() -> String? {
        return "$"
    }
}
