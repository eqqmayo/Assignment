//
//  TableViewCell.swift
//  TodoList
//
//  Created by CaliaPark on 3/19/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var isDoneSwitch: UISwitch!
    
    @IBAction func switchValueChanged(_ sender: Any) {
        if isDoneSwitch.isOn {
            titleLabel.textColor = .gray
            titleLabel.attributedText = titleLabel.text?.strikeThrough()
        } else {
            titleLabel.textColor = .black
            titleLabel.attributedText = titleLabel.text?.removeStrikeThrough()
        }
    }
}

extension String {
    
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func removeStrikeThrough() -> NSAttributedString {   
            let attributeString = NSMutableAttributedString(string: self)
            attributeString.removeAttribute(
              NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributeString.length))
            return attributeString
        }
}
