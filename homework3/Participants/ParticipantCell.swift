//
//  ParticipantCell.swift
//  homework3
//
//  Created by Martina Hanusova on 31.03.18.
//  Copyright © 2018 Martina Hanusova. All rights reserved.
//

import UIKit
import Kingfisher

class ParticipantCell: UITableViewCell {
    var person: Person? {
        didSet {
            setup()
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup() {
        if let person = person {
            textLabel?.text = person.name
            let url = URL(string: "http://emarest.cz.mass-php-1.mit.etn.cz/api/png/\(person.icon)")
            imageView?.kf.setImage(with: url, completionHandler:{ [weak self] (_, _, _, _) in
                self?.setNeedsLayout()
            })
            detailTextLabel?.attributedText = scoreToString(scores: person.scores)
            detailTextLabel?.textColor = UIColor.gray
        }
    }
    
    private func scoreToString(scores: [ScoreType]) -> NSMutableAttributedString {
        let scoresSorted = scores.sorted(by: {score1, score2 in
            return score1.value > score2.value
        }).filter {score in
            return score.value > 0
        }
        let retVal = NSMutableAttributedString(string: "")
        for (index, score) in scoresSorted.enumerated() {
            if index < 4 {
                let scoreString = score.emoji
                let attrs = [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 22.0)]
                let attributedName = NSMutableAttributedString(string: scoreString, attributes: attrs)
                let nameString = " \(score.value)   "
                let attributedValue = NSMutableAttributedString(string: nameString)
                retVal.append(attributedName)
                retVal.append(attributedValue)
                
            }
        }
        return retVal
    }
    
}
