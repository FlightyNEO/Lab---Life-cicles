//
//  MessageTableViewCell.swift
//  Lab - Life cicles
//
//  Created by Arkadiy Grigoryanc on 12/03/2019.
//  Copyright © 2019 Arkadiy Grigoryanc. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var functionNameLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var colorView: UIView!
    
    var message: Message? {
        
        didSet {
            
            titleLabel.text = message?.title
            functionNameLabel.text = message?.functionName
            dateLabel.text = message?.dateString
            
            if let color = message?.color {
                colorView.backgroundColor = color
                colorView.layer.borderWidth = 0
                colorView.layer.borderColor = nil
            } else {
                colorView.backgroundColor = .white
                colorView.layer.borderWidth = 1
                colorView.layer.borderColor = UIColor.black.cgColor
            }
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = colorView.bounds.height / 2
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
