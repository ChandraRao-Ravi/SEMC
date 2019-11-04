//
//  DashboardCollectionViewCell.swift
//  SEMC
//
//  Created by Chandra Rao on 21/10/19.
//  Copyright © 2019 Chandra Rao. All rights reserved.
//

import UIKit

public enum GlowType: Int {
    case red = 1
    case blue
    case orange
}

protocol SEMCDataSource: NSObject {
    func getEnergyUnitsInkWh() -> Int?
    func getNumberOfDevices() -> String?
    func getEnergyEconomy() -> String?
    func getRank() -> String?
    func getRankSuperScript() -> String?
    func getNeighbours() -> String?
    func getMonthlySavings() -> String?
    func getSavingsCurrency() -> String?
}

class DashboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    weak var dataSource: SEMCDataSource? = nil
    var energyGlowtimer: Timer? = nil
    var economyGlowtimer: Timer? = nil
    var rankGlowtimer: Timer? = nil
    var savingsGlowtimer: Timer? = nil
    
    var energyTimer: Timer? = nil

    func customiseView(withValues value: CGFloat) {
        self.container.layer.masksToBounds = true
        self.container.layer.cornerRadius = self.container.frame.size.width / 2
        
        self.container.layer.borderColor = UIColor(hexString: "#4A417A").cgColor
        self.container.layer.borderWidth = 3.0
    }
    
    func customiseTitleLabel(withValues value: CGFloat) {
        self.titleLabel.layer.masksToBounds = true
        self.titleLabel.layer.cornerRadius = self.titleLabel.frame.size.width / 2
    }
    
    func customizeTextForDevices() {
        self.populateEnergyValues()
        energyTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.populateEnergyValues), userInfo: nil, repeats: true)
    }
    
    @objc func populateEnergyValues() {
        
        if let data = self.dataSource, let energy = data.getEnergyUnitsInkWh(), let devices = data.getNumberOfDevices() {
            let energyText = NSString(string: "\(energy) kWh\n\(devices) Devices")
            let energyStateAttributedText = NSMutableAttributedString.init(string: energyText as? String ?? "")
            
            if energy >= 820 && energy <= 830 {
                self.container.backgroundColor = UIColor(hexString: "#191962")
                if let existingTimer = energyGlowtimer {
                    existingTimer.invalidate()
                }
                energyGlowtimer = self.container.makeBorderGlow(withColor: "#66EDFB")
            } else if energy >= 831 && energy <= 840 {
                self.container.backgroundColor = UIColor(hexString: "#191962")
                if let existingTimer = energyGlowtimer {
                    existingTimer.invalidate()
                }
                energyGlowtimer = self.container.makeBorderGlow(withColor: "#FBD74E")
            } else if energy >= 841 && energy <= 850 {
                self.container.backgroundColor = UIColor(hexString: "#191962")
                if let existingTimer = energyGlowtimer {
                    existingTimer.invalidate()
                }
                energyGlowtimer = self.container.makeBorderGlow(withColor: "#ED3A33")
            }
            
            if let energyRange = energyText.range(of: "\(energy)") as? NSRange {
                energyStateAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-SemiBold", size: 53.0) ?? UIFont.systemFont(ofSize: 17),
                                                         NSAttributedString.Key.foregroundColor: UIColor.white],
                                                        range: energyRange)
            }
            
            if let kwhRange = energyText.range(of: "kWh") as? NSRange {
                energyStateAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 17.0) ?? UIFont.systemFont(ofSize: 17),
                                                         NSAttributedString.Key.foregroundColor: UIColor.white],
                                                        range: kwhRange)
            }
            
            if let devicesRange = energyText.range(of: "\(devices) Devices") as? NSRange {
                energyStateAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 16.0) ?? UIFont.systemFont(ofSize: 17),
                                                         NSAttributedString.Key.foregroundColor: UIColor.white],
                                                        range: devicesRange)
            }
            self.titleLabel.attributedText = energyStateAttributedText
        }else {
            let emptyStateText = NSString(string: "0 kWh\n0 Devices")
            let emptyStateAttributedText = NSMutableAttributedString.init(string: emptyStateText as? String ?? "")
            
            
            emptyStateAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-SemiBold", size: 53.0) ?? UIFont.systemFont(ofSize: 17),
                                                    NSAttributedString.Key.foregroundColor: UIColor.white],
                                                   range: NSMakeRange(0, 1))
            
            if let kwhRange = emptyStateText.range(of: "kWh") as? NSRange {
                emptyStateAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 17.0) ?? UIFont.systemFont(ofSize: 17),
                                                        NSAttributedString.Key.foregroundColor: UIColor.white],
                                                       range: kwhRange)
            }
            
            if let devicesRange = emptyStateText.range(of: "0 Devices") as? NSRange {
                emptyStateAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 15.0) ?? UIFont.systemFont(ofSize: 17),
                                                        NSAttributedString.Key.foregroundColor: UIColor.white],
                                                       range: devicesRange)
            }
            self.titleLabel.attributedText = emptyStateAttributedText
        }
    }
    
    func customizeTextForEconomy() {
        if let existingTimer = economyGlowtimer {
            existingTimer.invalidate()
        }
        economyGlowtimer = self.container.makeBorderGlow(withColor: "#4A417A")
        self.container.backgroundColor = UIColor(hexString: "#281A62")

        self.titleLabel.font =  UIFont(name: "SFProText-SemiBold", size: 53.0)
        if let data = self.dataSource, let economy = data.getEnergyEconomy() {
            self.titleLabel.text = economy
        } else {
            self.titleLabel.text = "NA"
        }
    }
    
    func customizeTextForRank() {
        if let existingTimer = rankGlowtimer {
            existingTimer.invalidate()
        }
        rankGlowtimer = self.container.makeBorderGlow(withColor: "#4A417A")
        self.container.backgroundColor = UIColor(hexString: "#281A62")
        
        if let data = self.dataSource, let rank = data.getRank(), let superScript = data.getRankSuperScript(), let neighbours = data.getNeighbours() {
            self.titleLabel.setAttributedTextWithSubscripts(text: "\(rank)\(superScript) Rank\nAmong \(neighbours) neighbours", indicesOfSubscripts: [1,2])
            
            let rankText = NSString(string: "\(rank)\(superScript) Rank\nAmong \(neighbours) neighbours")
            let rankTextAttributedText = NSMutableAttributedString.init(string: rankText as? String ?? "")
            
            if let rankRange = rankText.range(of: rank) as? NSRange {
                rankTextAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-SemiBold", size: 53.0) ?? UIFont.systemFont(ofSize: 17),
                                                      NSAttributedString.Key.foregroundColor: UIColor.white],
                                                     range: rankRange)
            }
            if let superScriptRange = rankText.range(of: superScript) as? NSRange {
                rankTextAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 17),
                                                      NSAttributedString.Key.foregroundColor: UIColor.white],
                                                     range: superScriptRange)
            }
            if let rank = rankText.range(of: "Rank") as? NSRange {
                rankTextAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 17.0) ?? UIFont.systemFont(ofSize: 17),
                                                      NSAttributedString.Key.foregroundColor: UIColor.white],
                                                     range: rank)
            }
            if let remainingRange = rankText.range(of: "Among \(neighbours) neighbours") as? NSRange {
                rankTextAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 18.0) ?? UIFont.systemFont(ofSize: 17),
                                                      NSAttributedString.Key.foregroundColor: UIColor.white],
                                                     range: remainingRange)
            }
            self.titleLabel.attributedText = rankTextAttributedText
        } else {
            self.titleLabel.font =  UIFont(name: "SFProText-Regular", size: 53.0)
            self.titleLabel.text = "NA"
        }
    }
    
    func customizeTextForSavings() {
        if let existingTimer = savingsGlowtimer {
            existingTimer.invalidate()
        }
        savingsGlowtimer = self.container.makeBorderGlow(withColor: "#FBD74E")
        self.container.backgroundColor = UIColor(hexString: "#191962")

        self.titleLabel.font =  UIFont(name: "SFProText-Regular", size: 53.0)
        if let data = self.dataSource, let savings = data.getMonthlySavings(), let currency = data.getSavingsCurrency() {
            let savingsText = NSString(string: "\(currency) \(savings)\nMonthly Savings")
            let savingsAttributedText = NSMutableAttributedString.init(string: savingsText as? String ?? "")
            
            if let currencyRange = savingsText.range(of: currency) as? NSRange {
                savingsAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-SemiBold", size: 31.0) ?? UIFont.systemFont(ofSize: 17),
                                                      NSAttributedString.Key.foregroundColor: UIColor.white],
                                                     range: currencyRange)
            }
            if let currencyAmountRange = savingsText.range(of: "\(savings)") as? NSRange {
                savingsAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-SemiBold", size: 53.0) ?? UIFont.systemFont(ofSize: 17),
                                                      NSAttributedString.Key.foregroundColor: UIColor.white],
                                                     range: currencyAmountRange)
            }
            if let remainingRange = savingsText.range(of: "Monthly Savings") as? NSRange {
                savingsAttributedText.setAttributes([NSAttributedString.Key.font: UIFont(name: "SFProText-Regular", size: 18.0) ?? UIFont.systemFont(ofSize: 17),
                                                     NSAttributedString.Key.foregroundColor: UIColor.white],
                                                    range: remainingRange)
            }
            self.titleLabel.attributedText = savingsAttributedText
        } else {
            self.titleLabel.font =  UIFont(name: "SFProText-Regular", size: 53.0)
            self.titleLabel.text = "NA"
        }
    }
}

extension UILabel {
    /// Sets the attributedText property of UILabel with an attributed string
    /// that displays the characters of the text at the given indices in subscript.
    func setAttributedTextWithSubscripts(text: String, indicesOfSubscripts: [Int]) {
        let font = self.font!
        let subscriptFont = font.withSize(font.pointSize * 0.5)
        let subscriptOffset = font.pointSize * 0.9
        let attributedString = NSMutableAttributedString(string: text, attributes: [.font: font])
        
        for index in indicesOfSubscripts {
            let range = NSRange(location: index, length: 1)
            attributedString.setAttributes([.font: subscriptFont,
                                            .baselineOffset: subscriptOffset],
                                           range: range)
        }
        self.attributedText = attributedString
    }
}

extension String {
    /// Returns the indices of all the numbers in the string.
    ///
    /// If a number is directly preceded by a dot/comma, the index of the dot/comma
    /// will also be returned.
    /// This accounts for potential numbers with decimal or thousands separators.
    var indicesOfNumbers: [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex
        while searchStartIndex < self.endIndex,
            let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits,
                                              range: searchStartIndex..<self.endIndex),
            !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            if index > 0 {
                let previousIndex = self.index(self.startIndex, offsetBy: index - 1)
                if let previousCharacter = self[previousIndex].unicodeScalars.first,
                    (previousCharacter == "." || previousCharacter == ",")
                {
                    indices.append(index - 1)
                }
            }
            indices.append(index)
            searchStartIndex = range.upperBound
        }
        return indices
    }
}

extension DashboardCollectionViewCell: DataDelegate {
    func invalidateTimer() {
        
    }
}
